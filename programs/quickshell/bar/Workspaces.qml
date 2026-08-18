import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick
import qs

Item {
    id: root
    implicitWidth: wsRow.implicitWidth
    implicitHeight: wsRow.implicitHeight

    readonly property var icons: ["󰲠", "󰲢", "󰲤", "󰲦", "󰲨", "󰲪", "󰲬", "󰲮", "󰲰", "󰿬"]

    Process { id: switchProc }

    function switchWorkspace(wsId) {
        switchProc.command = ["hyprctl", "dispatch", "hl.dsp.focus({workspace = " + wsId + "})"]
        switchProc.running = true
    }

    Row {
        id: wsRow
        anchors.verticalCenter: parent.verticalCenter
        spacing: 0

        Repeater {
            model: 10

            Rectangle {
                required property int index

                property int wsId: index + 1
                property bool isActive: Hyprland.focusedWorkspace !== null
                                     && Hyprland.focusedWorkspace.id === wsId
                property bool occupied: {
                    var wsList = Hyprland.workspaces.values
                    for (var i = 0; i < wsList.length; i++) {
                        if (wsList[i].id === wsId) return true
                    }
                    return false
                }
                property bool hovered: false

                width: wsLabel.implicitWidth + 20
                height: wsLabel.implicitHeight + 10
                radius: 3
                color: hovered ? Theme.cyan : (isActive ? Theme.blue : "transparent")

                Text {
                    id: wsLabel
                    anchors.centerIn: parent
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSize
                    color: (parent.hovered || parent.isActive) ? Theme.bg
                         : (parent.occupied ? Theme.fg : Theme.comment)
                    text: root.icons[parent.index]
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: parent.hovered = true
                    onExited: parent.hovered = false
                    onClicked: root.switchWorkspace(parent.wsId)
                }
            }
        }
    }
}
