import Quickshell
import Quickshell.Io
import QtQuick
import qs

Item {
    id: root
    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitHeight

    property string connection: ""

    Process {
        id: proc
        command: ["sh", "-c", "nmcli -t -f NAME connection show --active 2>/dev/null | head -1"]

        stdout: SplitParser {
            onRead: data => {
                var name = data.toString().trim()
                if (name) root.connection = name
            }
        }
    }

    Timer {
        interval: 10000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            root.connection = ""
            proc.running = true
        }
    }

    Text {
        id: label
        anchors.verticalCenter: parent.verticalCenter
        color: Theme.red
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        text: root.connection ? "󰖩  " + root.connection : "󰪏 Disconnected"
    }
}
