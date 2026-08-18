import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs

Scope {
    id: root

    PanelController { id: ctrl }

    IpcHandler {
        target: "overview"

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

            // Dimmed background
            Rectangle {
                anchors.fill: parent
                color: Theme.bgDark
                opacity: 0.7

                MouseArea {
                    anchors.fill: parent
                    onClicked: ctrl.hide()
                }
            }

            // Window grid
            Rectangle {
                anchors.centerIn: parent
                width: parent.width * 0.8
                height: parent.height * 0.7
                color: Theme.bg
                radius: Theme.barRadius * 2
                border.color: Theme.border
                border.width: 1

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 12

                    // Title
                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        color: Theme.fg
                        font.family: Theme.fontFamily
                        font.pixelSize: 18
                        font.bold: true
                        text: "Window Overview"
                    }

                    // Toplevel windows
                    GridLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        columns: 4
                        rowSpacing: 8
                        columnSpacing: 8

                        Repeater {
                            model: Hyprland.toplevels ? Hyprland.toplevels.values : []

                            Rectangle {
                                required property var modelData
                                Layout.fillWidth: true
                                Layout.preferredHeight: 120
                                color: mouseArea.containsMouse ? Theme.border : Theme.bgDark
                                radius: Theme.barRadius
                                border.color: Theme.border
                                border.width: modelData === Hyprland.activeToplevel ? 2 : 0

                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.margins: 8
                                    spacing: 4

                                    // Live preview via ScreencopyView
                                    ScreencopyView {
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                        captureSource: modelData
                                    }

                                    // Window title
                                    Text {
                                        Layout.fillWidth: true
                                        color: Theme.fg
                                        font.family: Theme.fontFamily
                                        font.pixelSize: 10
                                        text: modelData.title || modelData.appId || "Untitled"
                                        elide: Text.ElideRight
                                        horizontalAlignment: Text.AlignHCenter
                                    }
                                }

                                MouseArea {
                                    id: mouseArea
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: {
                                        // Focus the window and close overview
                                        if (modelData.address) {
                                            Hyprland.dispatch("focuswindow", "address:" + modelData.address)
                                        }
                                        ctrl.hide()
                                    }
                                }
                            }
                        }
                    }

                    // Empty state
                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        visible: !Hyprland.toplevels || Hyprland.toplevels.values.length === 0
                        color: Theme.comment
                        font.family: Theme.fontFamily
                        font.pixelSize: 14
                        text: "No windows open"
                    }
                }
            }

            Keys.onEscapePressed: ctrl.hide()
        }
    }
}
