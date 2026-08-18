import Quickshell
import Quickshell.Io
import QtQuick
import qs

Item {
    id: root
    implicitWidth: container.implicitWidth
    implicitHeight: container.implicitHeight

    // Toggle the PowerMenu via IPC (PowerMenu lives at shell level as a PanelWindow)
    Process {
        id: toggleProc
        command: ["qs", "ipc", "call", "power", "toggle"]
    }

    Rectangle {
        id: container
        anchors.verticalCenter: parent.verticalCenter
        implicitWidth: Math.max(label.implicitWidth, label.implicitHeight) + 12
        implicitHeight: implicitWidth
        color: Theme.powerBg
        radius: Theme.barRadius

        Text {
            id: label
            anchors.centerIn: parent
            color: Theme.bg
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize
            text: ""
        }

        MouseArea {
            anchors.fill: parent
            onClicked: toggleProc.running = true
        }
    }
}
