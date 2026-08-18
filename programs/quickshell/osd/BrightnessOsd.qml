import Quickshell
import Quickshell.Io
import QtQuick
import qs

Scope {
    id: root

    property real brightness: 0
    property real lastBrightness: -1
    property bool showOsd: false

    Process {
        id: proc
        command: ["sh", "-c", "brightnessctl info -m 2>/dev/null | awk -F, '{gsub(/%/,\"\",$4); print $4}'"]

        stdout: SplitParser {
            onRead: data => {
                var val = parseInt(data) || 0
                root.brightness = val / 100.0
            }
        }
    }

    Timer {
        interval: 500
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: proc.running = true
    }

    onBrightnessChanged: {
        if (root.lastBrightness >= 0 && Math.abs(root.brightness - root.lastBrightness) > 0.005) {
            root.showOsd = true
            hideTimer.restart()
        }
        root.lastBrightness = root.brightness
    }

    Timer {
        id: hideTimer
        interval: 2000
        onTriggered: root.showOsd = false
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            visible: root.showOsd
            color: "transparent"
            focusable: false

            anchors {
                bottom: true
                left: true
                right: true
            }

            exclusionMode: ExclusionMode.Ignore
            implicitHeight: 80
            margins.bottom: 60

            Rectangle {
                anchors.centerIn: parent
                width: 200
                height: 60
                radius: Theme.barRadius
                color: Theme.bg
                border.color: Theme.border
                border.width: 1

                opacity: root.showOsd ? 1.0 : 0.0
                Behavior on opacity {
                    NumberAnimation { duration: 200 }
                }

                Row {
                    anchors.centerIn: parent
                    spacing: 12

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        color: Theme.yellow
                        font.family: Theme.fontFamily
                        font.pixelSize: 24
                        text: "󰃟"
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 4

                        Text {
                            color: Theme.fg
                            font.family: Theme.fontFamily
                            font.pixelSize: Theme.fontSize
                            text: Math.round(root.brightness * 100) + "%"
                        }

                        Rectangle {
                            width: 120
                            height: 4
                            radius: 2
                            color: Theme.border

                            Rectangle {
                                width: parent.width * root.brightness
                                height: parent.height
                                radius: 2
                                color: Theme.yellow
                            }
                        }
                    }
                }
            }
        }
    }
}
