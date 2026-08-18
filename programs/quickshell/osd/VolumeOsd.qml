import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import qs

Scope {
    id: root

    property var node: Pipewire.defaultAudioSink
    property real lastVolume: -1
    property bool lastMuted: false
    property bool showOsd: false

    PwObjectTracker {
        objects: [root.node]
    }

    property real currentVolume: root.node && root.node.audio ? root.node.audio.volume : 0
    property bool currentMuted: root.node && root.node.audio ? root.node.audio.muted : false

    onCurrentVolumeChanged: {
        if (root.lastVolume >= 0 && Math.abs(root.currentVolume - root.lastVolume) > 0.001) {
            root.showOsd = true
            hideTimer.restart()
        }
        root.lastVolume = root.currentVolume
    }

    onCurrentMutedChanged: {
        if (root.lastVolume >= 0) {
            root.showOsd = true
            hideTimer.restart()
        }
        root.lastMuted = root.currentMuted
    }

    Timer {
        id: hideTimer
        interval: 2000
        onTriggered: root.showOsd = false
    }

    property string icon: {
        if (root.currentMuted) return ""
        if (root.currentVolume < 0.33) return ""
        if (root.currentVolume < 0.66) return ""
        return ""
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
                        text: root.icon
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 4

                        Text {
                            color: Theme.fg
                            font.family: Theme.fontFamily
                            font.pixelSize: Theme.fontSize
                            text: root.currentMuted ? "Muted" : Math.round(root.currentVolume * 100) + "%"
                        }

                        // Progress bar
                        Rectangle {
                            width: 120
                            height: 4
                            radius: 2
                            color: Theme.border

                            Rectangle {
                                width: parent.width * root.currentVolume
                                height: parent.height
                                radius: 2
                                color: root.currentMuted ? Theme.comment : Theme.yellow
                            }
                        }
                    }
                }
            }
        }
    }
}
