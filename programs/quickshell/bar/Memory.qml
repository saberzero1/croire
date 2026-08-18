import Quickshell
import Quickshell.Io
import QtQuick
import qs

Item {
    id: root
    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitHeight

    property int usage: 0

    Process {
        id: proc
        command: ["sh", "-c", "free | awk '/Mem:/ {printf \"%d\", $3/$2*100}'"]

        stdout: SplitParser {
            onRead: data => {
                root.usage = parseInt(data) || 0
            }
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: proc.running = true
    }

    Text {
        id: label
        anchors.verticalCenter: parent.verticalCenter
        color: Theme.cyan
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        text: "󰍛 " + root.usage + "%"
    }
}
