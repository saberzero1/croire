import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs

Scope {
    id: root

    PanelController { id: ctrl }
    property var devices: []

    IpcHandler {
        target: "bluetooth"

        function toggle(): string {
            ctrl.toggle()
            if (ctrl.open) scanProc.running = true
            return ctrl.open ? "opened" : "closed"
        }
    }

    // List paired/known Bluetooth devices
    Process {
        id: scanProc
        command: ["sh", "-c", "bluetoothctl devices 2>/dev/null"]

        stdout: SplitParser {
            onRead: data => {
                var line = data.toString().trim()
                // Format: "Device XX:XX:XX:XX:XX:XX Name"
                var match = line.match(/^Device\s+(\S+)\s+(.+)$/)
                if (match) {
                    var list = root.devices.slice()
                    list.push({
                        mac: match[1],
                        name: match[2]
                    })
                    root.devices = list
                }
            }
        }

        onRunningChanged: {
            if (running) root.devices = []
        }
    }

    // Check connection status for each device
    Process {
        id: infoProc
        property string targetMac: ""
        command: ["bluetoothctl", "info", targetMac]

        stdout: SplitParser {
            onRead: data => {
                var line = data.toString().trim()
                if (line.startsWith("Connected:")) {
                    var connected = line.includes("yes")
                    var devList = root.devices.slice()
                    for (var i = 0; i < devList.length; i++) {
                        if (devList[i].mac === infoProc.targetMac) {
                            devList[i].connected = connected
                        }
                    }
                    root.devices = devList
                }
            }
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
            implicitWidth: 300
            implicitHeight: btContent.implicitHeight + 30
            margins.top: 50
            margins.right: 340

            Rectangle {
                anchors.fill: parent
                anchors.margins: 5
                color: Theme.bg
                border.color: Theme.border
                border.width: 1
                radius: Theme.barRadius

                ColumnLayout {
                    id: btContent
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 8

                    Text {
                        color: Theme.fg
                        font.family: Theme.fontFamily
                        font.pixelSize: Theme.fontSize
                        font.bold: true
                        text: "Bluetooth Devices"
                    }

                    Repeater {
                        model: root.devices

                        Rectangle {
                            required property var modelData
                            Layout.fillWidth: true
                            implicitHeight: 36
                            color: btMouse.containsMouse ? Theme.border : "transparent"
                            radius: 4

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 8
                                spacing: 8

                                Text {
                                    color: modelData.connected ? Theme.blue : Theme.comment
                                    font.family: Theme.fontFamily
                                    font.pixelSize: 14
                                    text: "󰂯"
                                }

                                Text {
                                    Layout.fillWidth: true
                                    color: Theme.fg
                                    font.family: Theme.fontFamily
                                    font.pixelSize: 12
                                    text: modelData.name || modelData.mac
                                    elide: Text.ElideRight
                                }

                                Text {
                                    color: modelData.connected ? Theme.green : Theme.comment
                                    font.family: Theme.fontFamily
                                    font.pixelSize: 10
                                    text: modelData.connected ? "Connected" : "Paired"
                                }
                            }

                            MouseArea {
                                id: btMouse
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    var action = modelData.connected ? "disconnect" : "connect"
                                    btActionProc.command = ["bluetoothctl", action, modelData.mac]
                                    btActionProc.running = true
                                }
                            }
                        }
                    }

                    Text {
                        visible: root.devices.length === 0
                        color: Theme.comment
                        font.family: Theme.fontFamily
                        font.pixelSize: 12
                        text: "No devices found"
                    }
                }
            }

            Keys.onEscapePressed: ctrl.hide()
        }
    }

    Process {
        id: btActionProc
        onExited: scanProc.running = true
    }
}
