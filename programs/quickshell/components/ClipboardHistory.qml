import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs

Scope {
    id: root

    property var entries: []
    property string filterText: ""
    property int maxEntries: 50

    PanelController { id: ctrl }

    IpcHandler {
        target: "clipboard"
        function toggle(): string { ctrl.toggle(); return ctrl.open ? "opened" : "closed" }
        function clear(): string { root.entries = []; return "cleared" }
    }

    Process {
        id: watchProc
        command: ["wl-paste", "--type", "text", "--watch", "cat"]
        stdout: SplitParser {
            onRead: data => {
                var text = data.toString().trim()
                if (!text) return
                var filtered = root.entries.filter(e => e.text !== text)
                filtered.unshift({text: text, timestamp: Date.now()})
                if (filtered.length > root.maxEntries)
                    filtered = filtered.slice(0, root.maxEntries)
                root.entries = filtered
            }
        }
    }

    Component.onCompleted: watchProc.running = true

    function pasteEntry(text) {
        pasteProc.command = ["wl-copy", text]
        pasteProc.running = true
        ctrl.hide()
    }

    function removeEntry(index) {
        var list = root.entries.slice()
        list.splice(index, 1)
        root.entries = list
    }

    Process { id: pasteProc }

    readonly property var filteredEntries: {
        var q = filterText.toLowerCase().trim()
        if (!q) return entries
        return entries.filter(e => e.text.toLowerCase().includes(q))
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
                width: 500; height: 400
                color: Theme.bg; radius: Theme.barRadius
                border.color: Theme.border; border.width: 1

                ColumnLayout {
                    anchors.fill: parent; anchors.margins: 12; spacing: 8

                    RowLayout {
                        Layout.fillWidth: true
                        Text {
                            color: Theme.fg; font.family: Theme.fontFamily
                            font.pixelSize: 16; font.bold: true
                            text: "Clipboard History"
                        }
                        Item { Layout.fillWidth: true }
                        Text {
                            color: Theme.comment; font.family: Theme.fontFamily
                            font.pixelSize: 11
                            text: root.entries.length + " items"
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true; height: 32
                        color: Theme.bgDark; radius: 4

                        TextInput {
                            id: clipSearch
                            anchors.fill: parent; anchors.margins: 8
                            color: Theme.fg; font.family: Theme.fontFamily
                            font.pixelSize: 12; clip: true
                            onTextChanged: root.filterText = text
                            Keys.onEscapePressed: ctrl.hide()

                            Text {
                                anchors.fill: parent; color: Theme.comment
                                font: parent.font; text: "Search..."
                                visible: !parent.text && !parent.activeFocus
                            }
                        }
                    }

                    ListView {
                        Layout.fillWidth: true; Layout.fillHeight: true
                        clip: true; spacing: 2
                        model: root.filteredEntries

                        delegate: Rectangle {
                            required property var modelData
                            required property int index
                            width: ListView.view.width; height: 36
                            color: clipMouse.containsMouse ? Theme.border : "transparent"
                            radius: 4

                            RowLayout {
                                anchors.fill: parent; anchors.margins: 8; spacing: 8
                                Text {
                                    Layout.fillWidth: true; color: Theme.fg
                                    font.family: Theme.fontFamily; font.pixelSize: 12
                                    text: modelData.text.substring(0, 80).replace(/\n/g, " ")
                                    elide: Text.ElideRight
                                }
                                Text {
                                    color: Theme.comment; font.family: Theme.fontFamily
                                    font.pixelSize: 12; text: "×"
                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: root.removeEntry(index)
                                    }
                                }
                            }

                            MouseArea {
                                id: clipMouse; anchors.fill: parent
                                hoverEnabled: true; z: -1
                                onClicked: root.pasteEntry(modelData.text)
                            }
                        }
                    }
                }
            }

            onVisibleChanged: {
                if (visible) { clipSearch.text = ""; clipSearch.forceActiveFocus() }
            }
            Keys.onEscapePressed: ctrl.hide()
        }
    }
}
