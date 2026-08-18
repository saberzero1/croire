import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import qs

Scope {
    id: root

    PanelController { id: ctrl }
    property var player: Mpris.players.values.length > 0 ? Mpris.players.values[0] : null

    IpcHandler {
        target: "media"

        function toggle(): string {
            ctrl.toggle()
            return ctrl.open ? "opened" : "closed"
        }
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            visible: ctrl.open && root.player !== null
            focusable: false
            color: "transparent"

            anchors {
                bottom: true
                right: true
            }

            exclusionMode: ExclusionMode.Ignore
            implicitWidth: 360
            implicitHeight: 120
            margins.bottom: 10
            margins.right: 10

            Rectangle {
                anchors.fill: parent
                anchors.margins: 5
                color: Theme.bg
                border.color: Theme.border
                border.width: 1
                radius: Theme.barRadius

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 12

                    // Album art
                    Rectangle {
                        Layout.preferredWidth: 80
                        Layout.preferredHeight: 80
                        radius: 4
                        color: Theme.border
                        clip: true

                        Image {
                            anchors.fill: parent
                            source: root.player && root.player.trackArtUrl ? root.player.trackArtUrl : ""
                            fillMode: Image.PreserveAspectCrop
                            visible: source !== ""
                        }

                        Text {
                            anchors.centerIn: parent
                            color: Theme.comment
                            font.family: Theme.fontFamily
                            font.pixelSize: 24
                            text: "♪"
                            visible: !root.player || !root.player.trackArtUrl
                        }
                    }

                    // Track info + controls
                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        spacing: 4

                        // Title
                        Text {
                            Layout.fillWidth: true
                            color: Theme.fg
                            font.family: Theme.fontFamily
                            font.pixelSize: Theme.fontSize
                            font.bold: true
                            text: root.player ? (root.player.trackTitle || "Unknown") : ""
                            elide: Text.ElideRight
                        }

                        // Artist
                        Text {
                            Layout.fillWidth: true
                            color: Theme.comment
                            font.family: Theme.fontFamily
                            font.pixelSize: 12
                            text: root.player ? (root.player.trackArtist || "Unknown artist") : ""
                            elide: Text.ElideRight
                        }

                        Item { Layout.fillHeight: true }

                        // Controls
                        RowLayout {
                            spacing: 16

                            Text {
                                color: Theme.fg
                                font.family: Theme.fontFamily
                                font.pixelSize: 18
                                text: "󰒮"
                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: { if (root.player) root.player.previous() }
                                }
                            }

                            Text {
                                color: Theme.blue
                                font.family: Theme.fontFamily
                                font.pixelSize: 22
                                text: root.player && root.player.isPlaying ? "󰏤" : "󰐊"
                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: { if (root.player) root.player.togglePlaying() }
                                }
                            }

                            Text {
                                color: Theme.fg
                                font.family: Theme.fontFamily
                                font.pixelSize: 18
                                text: "󰒭"
                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: { if (root.player) root.player.next() }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
