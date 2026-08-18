import Quickshell
import Quickshell.Io
import QtQuick
import qs

Scope {
    id: root

    PanelController { id: ctrl }
    property bool selecting: false
    property point startPoint: Qt.point(0, 0)
    property point endPoint: Qt.point(0, 0)

    IpcHandler {
        target: "screenshot"

        function area(): string {
            ctrl.show()
            return "opened"
        }

        function full(): string {
            captureFullProc.running = true
            return "capturing full screen"
        }
    }

    // Capture via grim with region
    Process {
        id: captureProc
        property string region: ""
        command: ["sh", "-c", "grim -g '" + region + "' - | wl-copy"]
    }

    Process {
        id: captureFullProc
        command: ["sh", "-c", "grim - | wl-copy"]
    }

    Process {
        id: captureSaveProc
        property string region: ""
        command: ["sh", "-c", "grim -g '" + region + "' ~/Pictures/Screenshots/Screenshot-$(date +'%Y-%m-%d-%H%M%S').png"]
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
                bottom: true
                left: true
                right: true
            }

            exclusionMode: ExclusionMode.Ignore

            // Semi-transparent overlay
            Rectangle {
                anchors.fill: parent
                color: Theme.bgDark
                opacity: 0.3
            }

            // Selection rectangle
            Rectangle {
                visible: root.selecting
                x: Math.min(root.startPoint.x, root.endPoint.x)
                y: Math.min(root.startPoint.y, root.endPoint.y)
                width: Math.abs(root.endPoint.x - root.startPoint.x)
                height: Math.abs(root.endPoint.y - root.startPoint.y)
                color: "transparent"
                border.color: Theme.blue
                border.width: 2

                // Dimension label
                Text {
                    anchors.top: parent.bottom
                    anchors.topMargin: 4
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: Theme.fg
                    font.family: Theme.fontFamily
                    font.pixelSize: 11
                    text: Math.round(parent.width) + " × " + Math.round(parent.height)
                    visible: parent.width > 0 && parent.height > 0

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: -4
                        color: Theme.bg
                        radius: 2
                        z: -1
                    }
                }
            }

            // Instructions
            Text {
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                color: Theme.fg
                font.family: Theme.fontFamily
                font.pixelSize: 14
                text: "Click and drag to select region · Escape to cancel"
                visible: !root.selecting

                Rectangle {
                    anchors.fill: parent
                    anchors.margins: -8
                    color: Theme.bg
                    radius: Theme.barRadius
                    z: -1
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.CrossCursor

                onPressed: function(mouse) {
                    root.selecting = true
                    root.startPoint = Qt.point(mouse.x, mouse.y)
                    root.endPoint = Qt.point(mouse.x, mouse.y)
                }

                onPositionChanged: function(mouse) {
                    if (root.selecting) {
                        root.endPoint = Qt.point(mouse.x, mouse.y)
                    }
                }

                onReleased: function(mouse) {
                    root.selecting = false
                    ctrl.hide()

                    var x = Math.min(root.startPoint.x, root.endPoint.x)
                    var y = Math.min(root.startPoint.y, root.endPoint.y)
                    var w = Math.abs(root.endPoint.x - root.startPoint.x)
                    var h = Math.abs(root.endPoint.y - root.startPoint.y)

                    if (w > 5 && h > 5) {
                        var region = Math.round(x) + "," + Math.round(y) + " " + Math.round(w) + "x" + Math.round(h)
                        captureProc.region = region
                        captureProc.running = true
                    }
                }
            }

            Keys.onEscapePressed: {
                root.selecting = false
                ctrl.hide()
            }
        }
    }
}
