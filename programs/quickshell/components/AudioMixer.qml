import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import qs

Scope {
    id: root

    PanelController { id: ctrl }

    IpcHandler {
        target: "mixer"

        function toggle(): string {
            ctrl.toggle()
            return ctrl.open ? "opened" : "closed"
        }
    }

    // Track all stream nodes
    property var streams: {
        if (!Pipewire.nodes || !Pipewire.nodes.values) return []
        return Pipewire.nodes.values.filter(function(node) {
            return (node.type & PwNodeType.AudioOutStream) === PwNodeType.AudioOutStream
        })
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
            implicitWidth: 350
            implicitHeight: mixerContent.implicitHeight + 30
            margins.top: 50
            margins.right: 10

            MouseArea {
                anchors.fill: parent
                onClicked: {} // Prevent click-through
            }

            Rectangle {
                anchors.fill: parent
                anchors.margins: 5
                color: Theme.bg
                border.color: Theme.border
                border.width: 1
                radius: Theme.barRadius

                ColumnLayout {
                    id: mixerContent
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 12

                    // Title
                    Text {
                        color: Theme.fg
                        font.family: Theme.fontFamily
                        font.pixelSize: Theme.fontSize
                        font.bold: true
                        text: "Audio Mixer"
                    }

                    // Master volume
                    Rectangle {
                        Layout.fillWidth: true
                        implicitHeight: masterCol.implicitHeight + 16
                        color: Theme.bgDark
                        radius: 4

                        ColumnLayout {
                            id: masterCol
                            anchors.fill: parent
                            anchors.margins: 8
                            spacing: 6

                            RowLayout {
                                Layout.fillWidth: true

                                Text {
                                    color: Theme.yellow
                                    font.family: Theme.fontFamily
                                    font.pixelSize: 16
                                    text: ""
                                }

                                Text {
                                    Layout.fillWidth: true
                                    color: Theme.fg
                                    font.family: Theme.fontFamily
                                    font.pixelSize: 12
                                    text: "Master"
                                }

                                Text {
                                    color: Theme.comment
                                    font.family: Theme.fontFamily
                                    font.pixelSize: 12
                                    text: {
                                        var sink = Pipewire.defaultAudioSink
                                        if (!sink || !sink.audio) return "0%"
                                        return Math.round(sink.audio.volume * 100) + "%"
                                    }
                                }
                            }

                            // Volume slider
                            Rectangle {
                                Layout.fillWidth: true
                                height: 6
                                radius: 3
                                color: Theme.border

                                Rectangle {
                                    width: {
                                        var sink = Pipewire.defaultAudioSink
                                        if (!sink || !sink.audio) return 0
                                        return parent.width * Math.min(sink.audio.volume, 1.0)
                                    }
                                    height: parent.height
                                    radius: 3
                                    color: Theme.yellow
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: function(mouse) {
                                        var sink = Pipewire.defaultAudioSink
                                        if (sink && sink.audio) {
                                            sink.audio.volume = mouse.x / parent.width
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // App streams
                    Repeater {
                        model: root.streams

                        Rectangle {
                            required property var modelData
                            Layout.fillWidth: true
                            implicitHeight: streamCol.implicitHeight + 16
                            color: Theme.bgDark
                            radius: 4

                            PwObjectTracker {
                                objects: [modelData]
                            }

                            ColumnLayout {
                                id: streamCol
                                anchors.fill: parent
                                anchors.margins: 8
                                spacing: 6

                                RowLayout {
                                    Layout.fillWidth: true

                                    Text {
                                        color: Theme.blue
                                        font.family: Theme.fontFamily
                                        font.pixelSize: 14
                                        text: "󰝚"
                                    }

                                    Text {
                                        Layout.fillWidth: true
                                        color: Theme.fg
                                        font.family: Theme.fontFamily
                                        font.pixelSize: 12
                                        text: modelData.properties ? (modelData.properties["application.name"] || modelData.description || modelData.name || "Stream") : "Stream"
                                        elide: Text.ElideRight
                                    }

                                    Text {
                                        color: Theme.comment
                                        font.family: Theme.fontFamily
                                        font.pixelSize: 12
                                        text: modelData.audio ? Math.round(modelData.audio.volume * 100) + "%" : "—"
                                    }
                                }

                                Rectangle {
                                    Layout.fillWidth: true
                                    height: 6
                                    radius: 3
                                    color: Theme.border

                                    Rectangle {
                                        width: modelData.audio ? parent.width * Math.min(modelData.audio.volume, 1.0) : 0
                                        height: parent.height
                                        radius: 3
                                        color: Theme.blue
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: function(mouse) {
                                            if (modelData.audio) {
                                                modelData.audio.volume = mouse.x / parent.width
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // Empty state
                    Text {
                        visible: root.streams.length === 0
                        color: Theme.comment
                        font.family: Theme.fontFamily
                        font.pixelSize: 12
                        text: "No audio streams"
                    }
                }
            }

            Keys.onEscapePressed: ctrl.hide()
        }
    }
}
