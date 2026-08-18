import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs

Scope {
    id: root

    property var reminders: []
    property int nextId: 1

    PanelController { id: ctrl }

    IpcHandler {
        target: "reminders"

        function show(): string { ctrl.toggle(); return ctrl.open ? "opened" : "closed" }

        function add(message: string, seconds: string): string {
            var secs = parseInt(seconds)
            if (isNaN(secs) || secs <= 0) return "error: invalid seconds"
            var reminder = {
                id: root.nextId++,
                message: message,
                triggerTime: Date.now() + secs * 1000,
                fired: false
            }
            var list = root.reminders.slice()
            list.push(reminder)
            root.reminders = list
            return "reminder set: " + message + " in " + secs + "s (id=" + reminder.id + ")"
        }

        function remove(idStr: string): string {
            var rid = parseInt(idStr)
            var list = root.reminders.filter(r => r.id !== rid)
            if (list.length === root.reminders.length) return "not found"
            root.reminders = list
            return "removed"
        }

        function list(): string {
            if (root.reminders.length === 0) return "no reminders"
            return root.reminders.map(r => {
                var remaining = Math.max(0, Math.round((r.triggerTime - Date.now()) / 1000))
                return "#" + r.id + " " + r.message + " (" + remaining + "s remaining)"
            }).join("\n")
        }
    }

    Process { id: notifyProc }

    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: {
            var now = Date.now()
            var changed = false
            var remaining = []
            for (var i = 0; i < root.reminders.length; i++) {
                var r = root.reminders[i]
                if (!r.fired && now >= r.triggerTime) {
                    notifyProc.command = ["notify-send", "-u", "critical",
                                          "Reminder", r.message]
                    notifyProc.running = true
                    changed = true
                } else if (!r.fired && now < r.triggerTime) {
                    remaining.push(r)
                }
            }
            if (changed) root.reminders = remaining
        }
    }

    function formatRemaining(triggerTime) {
        var secs = Math.max(0, Math.round((triggerTime - Date.now()) / 1000))
        if (secs >= 3600) {
            var h = Math.floor(secs / 3600)
            var m = Math.floor((secs % 3600) / 60)
            return h + "h " + m + "m"
        }
        if (secs >= 60) {
            var mins = Math.floor(secs / 60)
            var s = secs % 60
            return mins + "m " + s + "s"
        }
        return secs + "s"
    }

    function removeReminder(id) {
        root.reminders = root.reminders.filter(r => r.id !== id)
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData
            visible: ctrl.open
            focusable: true
            color: "transparent"

            anchors { top: true; bottom: true; left: true; right: true }
            exclusionMode: ExclusionMode.Ignore

            MouseArea { anchors.fill: parent; onClicked: ctrl.hide() }

            Rectangle {
                anchors.centerIn: parent
                width: 400; height: 350
                color: Theme.bg; radius: Theme.barRadius
                border.color: Theme.border; border.width: 1

                ColumnLayout {
                    anchors.fill: parent; anchors.margins: 12; spacing: 8

                    RowLayout {
                        Layout.fillWidth: true
                        Text {
                            color: Theme.fg; font.family: Theme.fontFamily
                            font.pixelSize: 16; font.bold: true
                            text: "Reminders"
                        }
                        Item { Layout.fillWidth: true }
                        Text {
                            color: Theme.comment; font.family: Theme.fontFamily
                            font.pixelSize: 11
                            text: root.reminders.length + " active"
                        }
                    }

                    // Info text
                    Text {
                        Layout.fillWidth: true
                        color: Theme.comment; font.family: Theme.fontFamily
                        font.pixelSize: 10; wrapMode: Text.WordWrap
                        text: "Add via CLI: qs ipc call reminders add \"message\" \"seconds\""
                    }

                    // Reminders list
                    ListView {
                        Layout.fillWidth: true; Layout.fillHeight: true
                        clip: true; spacing: 4
                        model: root.reminders

                        delegate: Rectangle {
                            required property var modelData
                            required property int index
                            width: ListView.view.width; height: 52
                            color: Theme.bgDark; radius: 4

                            RowLayout {
                                anchors.fill: parent; anchors.margins: 10; spacing: 8

                                ColumnLayout {
                                    Layout.fillWidth: true; spacing: 2

                                    Text {
                                        Layout.fillWidth: true
                                        color: Theme.fg; font.family: Theme.fontFamily
                                        font.pixelSize: 12
                                        text: modelData.message; elide: Text.ElideRight
                                    }
                                    Text {
                                        color: Theme.cyan; font.family: Theme.fontFamily
                                        font.pixelSize: 10
                                        text: root.formatRemaining(modelData.triggerTime) + " remaining"
                                    }
                                }

                                Text {
                                    color: Theme.comment; font.family: Theme.fontFamily
                                    font.pixelSize: 14; text: "×"
                                    MouseArea {
                                        anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                                        onClicked: root.removeReminder(modelData.id)
                                    }
                                }
                            }
                        }

                        // Empty state
                        Text {
                            anchors.centerIn: parent
                            visible: root.reminders.length === 0
                            color: Theme.comment; font.family: Theme.fontFamily
                            font.pixelSize: 13
                            text: "No active reminders"
                        }
                    }
                }
            }

            Keys.onEscapePressed: ctrl.hide()
        }
    }
}
