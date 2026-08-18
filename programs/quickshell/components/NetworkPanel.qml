import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs

Scope {
    id: root

    PanelController { id: ctrl }
    property var networks: []
    property string activeConnection: ""

    IpcHandler {
        target: "network"

        function toggle(): string {
            ctrl.toggle()
            if (ctrl.open) scanProc.running = true
            return ctrl.open ? "opened" : "closed"
        }
    }

    // Scan for WiFi networks
    Process {
        id: scanProc
        command: ["nmcli", "-t", "-f", "SSID,SIGNAL,SECURITY,IN-USE", "dev", "wifi", "list", "--rescan", "auto"]

        stdout: SplitParser {
            onRead: data => {
                var line = data.toString().trim()
                if (!line) return
                var parts = line.split(":")
                if (parts.length >= 4) {
                    var list = root.networks.slice()
                    list.push({
                        ssid: parts[0],
                        signal: parseInt(parts[1]) || 0,
                        security: parts[2],
                        inUse: parts[3] === "*"
                    })
                    root.networks = list
                }
            }
        }

        onRunningChanged: {
            if (running) root.networks = []
        }
    }

    // Get active connection
    Process {
        id: activeProc
        command: ["sh", "-c", "nmcli -t -f NAME connection show --active 2>/dev/null | head -1"]

        stdout: SplitParser {
            onRead: data => {
                root.activeConnection = data.toString().trim()
            }
        }
    }

    Timer {
        interval: 15000
        running: ctrl.open
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            scanProc.running = true
            activeProc.running = true
        }
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            visible: ctrl.open
            focusable: true
            color: "transparent"

            anchors {
                top: true
                right: true
            }

            exclusionMode: ExclusionMode.Ignore
            implicitWidth: 320
            implicitHeight: netContent.implicitHeight + 30
            margins.top: 50
            margins.right: 10

            Rectangle {
                anchors.fill: parent
                anchors.margins: 5
                color: Theme.bg
                border.color: Theme.border
                border.width: 1
                radius: Theme.barRadius

                ColumnLayout {
                    id: netContent
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 8

                    // Title
                    RowLayout {
                        Layout.fillWidth: true

                        Text {
                            Layout.fillWidth: true
                            color: Theme.fg
                            font.family: Theme.fontFamily
                            font.pixelSize: Theme.fontSize
                            font.bold: true
                            text: "WiFi Networks"
                        }

                        Text {
                            color: Theme.comment
                            font.family: Theme.fontFamily
                            font.pixelSize: 12
                            text: root.activeConnection ? "Connected: " + root.activeConnection : "Disconnected"
                        }
                    }

                    // Network list
                    Repeater {
                        model: root.networks.filter(function(n) { return n.ssid !== "" })

                        Rectangle {
                            required property var modelData
                            Layout.fillWidth: true
                            implicitHeight: 36
                            color: netMouse.containsMouse ? Theme.border : (modelData.inUse ? Theme.bgDark : "transparent")
                            radius: 4

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 8
                                spacing: 8

                                // Signal strength icon
                                Text {
                                    color: modelData.inUse ? Theme.green : Theme.comment
                                    font.family: Theme.fontFamily
                                    font.pixelSize: 14
                                    text: {
                                        if (modelData.signal >= 75) return "󰤨"
                                        if (modelData.signal >= 50) return "󰤥"
                                        if (modelData.signal >= 25) return "󰤢"
                                        return "󰤟"
                                    }
                                }

                                // SSID
                                Text {
                                    Layout.fillWidth: true
                                    color: modelData.inUse ? Theme.fg : Theme.comment
                                    font.family: Theme.fontFamily
                                    font.pixelSize: 12
                                    text: modelData.ssid
                                    elide: Text.ElideRight
                                }

                                // Security badge
                                Text {
                                    color: Theme.comment
                                    font.family: Theme.fontFamily
                                    font.pixelSize: 10
                                    text: modelData.security || "Open"
                                    visible: !modelData.inUse
                                }

                                // Connected indicator
                                Text {
                                    color: Theme.green
                                    font.family: Theme.fontFamily
                                    font.pixelSize: 10
                                    text: "Connected"
                                    visible: modelData.inUse
                                }
                            }

                            MouseArea {
                                id: netMouse
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    if (!modelData.inUse) {
                                        connectProc.command = ["nmcli", "device", "wifi", "connect", modelData.ssid]
                                        connectProc.running = true
                                    }
                                }
                            }
                        }
                    }

                    // Empty state
                    Text {
                        visible: root.networks.length === 0
                        color: Theme.comment
                        font.family: Theme.fontFamily
                        font.pixelSize: 12
                        text: "Scanning..."
                    }
                }
            }

            Keys.onEscapePressed: ctrl.hide()
        }
    }

    Process {
        id: connectProc
    }
}
