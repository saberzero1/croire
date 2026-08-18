import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts
import qs

Scope {
    id: root

    property var notifications: []
    property string stateDir: Quickshell.env("HOME") + "/.local/state/quickshell/notifications"
    property int nextPersistId: Date.now()

    // Create state directory on startup
    Process {
        id: mkdirProc
        command: ["mkdir", "-p", root.stateDir]
    }

    // Write a notification to disk
    Process {
        id: writeProc
        property string payload: ""
        property string filepath: ""
        command: ["sh", "-c", "echo '" + payload + "' > " + filepath]
    }

    // Delete a notification from disk
    Process {
        id: deleteProc
        property string filepath: ""
        command: ["rm", "-f", filepath]
    }

    // Restore persisted notifications on startup
    Process {
        id: restoreProc
        command: ["sh", "-c", "for f in " + root.stateDir + "/*.json; do [ -f \"$f\" ] && cat \"$f\"; done"]

        stdout: SplitParser {
            onRead: data => {
                try {
                    var entry = JSON.parse(data.toString().trim())
                    if (entry.summary) {
                        var notifList = root.notifications.slice()
                        notifList.push({
                            summary: entry.summary || "",
                            body: entry.body || "",
                            appName: entry.appName || "",
                            expireTimeout: -1,
                            _persistId: entry.id
                        })
                        root.notifications = notifList
                    }
                } catch (e) {}
            }
        }
    }

    Component.onCompleted: {
        mkdirProc.running = true
        restoreProc.running = true
    }

    function persistNotification(notification) {
        var id = root.nextPersistId++
        var data = {
            id: id,
            summary: notification.summary || "",
            body: notification.body || "",
            appName: notification.appName || "",
            timestamp: Date.now(),
            urgency: notification.urgency || 0
        }
        notification._persistId = id
        writeProc.payload = JSON.stringify(data)
        writeProc.filepath = root.stateDir + "/" + id + ".json"
        writeProc.running = true
    }

    function removePersistence(notification) {
        if (notification._persistId !== undefined) {
            deleteProc.filepath = root.stateDir + "/" + notification._persistId + ".json"
            deleteProc.running = true
        }
    }

    NotificationServer {
        id: server

        onNotification: notification => {
            // Add to list and auto-dismiss
            var notifList = root.notifications.slice()
            notifList.push(notification)
            root.notifications = notifList

            notification.tracked = true
            root.persistNotification(notification)
        }
    }

    function dismiss(notification) {
        root.removePersistence(notification)
        if (notification.dismiss) notification.dismiss()
        var idx = root.notifications.indexOf(notification)
        if (idx !== -1) {
            var notifList = root.notifications.slice()
            notifList.splice(idx, 1)
            root.notifications = notifList
        }
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            visible: root.notifications.length > 0
            color: "transparent"
            focusable: false

            anchors {
                top: true
                right: true
            }

            exclusionMode: ExclusionMode.Ignore
            implicitWidth: 360
            implicitHeight: notifColumn.implicitHeight + 20

            margins.top: 50
            margins.right: 10

            ColumnLayout {
                id: notifColumn
                anchors.fill: parent
                anchors.margins: 10
                spacing: 8

                Repeater {
                    model: root.notifications

                    Rectangle {
                        required property var modelData
                        Layout.fillWidth: true
                        implicitHeight: notifContent.implicitHeight + 20
                        color: Theme.bg
                        border.color: Theme.border
                        border.width: 1
                        radius: Theme.barRadius

                        ColumnLayout {
                            id: notifContent
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 4

                            Text {
                                Layout.fillWidth: true
                                color: Theme.fg
                                font.family: Theme.fontFamily
                                font.pixelSize: Theme.fontSize
                                font.bold: true
                                text: modelData.summary || ""
                                elide: Text.ElideRight
                            }

                            Text {
                                Layout.fillWidth: true
                                color: Theme.comment
                                font.family: Theme.fontFamily
                                font.pixelSize: 12
                                text: modelData.body || ""
                                wrapMode: Text.Wrap
                                maximumLineCount: 3
                                elide: Text.ElideRight
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: root.dismiss(modelData)
                        }

                        // Auto-dismiss timer
                        Timer {
                            interval: {
                                var timeout = modelData.expireTimeout
                                if (timeout <= 0) return 5000
                                return timeout
                            }
                            running: true
                            onTriggered: root.dismiss(modelData)
                        }
                    }
                }
            }
        }
    }
}
