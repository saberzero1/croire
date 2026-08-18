import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "../components"
import qs

Scope {
    id: root

    PanelController { id: ctrl }

    IpcHandler {
        target: "launcher"

        function toggle(): string {
            ctrl.toggle()
            return ctrl.open ? "opened" : "closed"
        }
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: launcherWindow
            required property var modelData
            screen: modelData

            visible: ctrl.open
            focusable: true
            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
                bottom: true
            }

            exclusionMode: ExclusionMode.Ignore

            // Click background to close
            MouseArea {
                anchors.fill: parent
                onClicked: ctrl.hide()
            }

            // Launcher dialog
            Rectangle {
                id: dialog
                width: 550
                height: 350
                anchors.centerIn: parent
                color: Theme.bg
                border.color: Theme.border
                border.width: 2
                radius: Theme.barRadius

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 5
                    spacing: 5

                    // Search input
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 36
                        color: Theme.bg
                        border.color: Theme.bg
                        border.width: 1

                        TextInput {
                            id: searchInput
                            anchors.fill: parent
                            anchors.margins: 8
                            color: Theme.fg
                            font.family: Theme.fontFamily
                            font.pixelSize: 12
                            clip: true

                            property string placeholderText: "Search applications..."

                            Text {
                                anchors.fill: parent
                                color: Theme.comment
                                font: parent.font
                                text: parent.placeholderText
                                visible: !parent.text && !parent.activeFocus
                            }

                            onTextChanged: {
                                LauncherModel.filterText = text
                            }

                            Keys.onEscapePressed: ctrl.hide()
                            Keys.onReturnPressed: {
                                if (LauncherModel.filteredEntries.length > 0) {
                                    LauncherModel.filteredEntries[0].execute()
                                    ctrl.hide()
                                }
                            }
                        }
                    }

                    // Results list
                    ListView {
                        id: resultsList
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        clip: true
                        model: LauncherModel.filteredEntries

                        delegate: Rectangle {
                            required property var modelData
                            required property int index
                            width: resultsList.width
                            height: 36
                            color: mouseArea.containsMouse ? Theme.border : "transparent"

                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 8
                                anchors.rightMargin: 8
                                spacing: 8

                                Text {
                                    Layout.fillWidth: true
                                    color: Theme.fg
                                    font.family: Theme.fontFamily
                                    font.pixelSize: 12
                                    text: modelData.name || ""
                                    elide: Text.ElideRight
                                }
                            }

                            MouseArea {
                                id: mouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    modelData.execute()
                                    ctrl.hide()
                                }
                            }
                        }
                    }
                }
            }

            onVisibleChanged: {
                if (visible) {
                    searchInput.text = ""
                    searchInput.forceActiveFocus()
                }
            }
        }
    }
}
