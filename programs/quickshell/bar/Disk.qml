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
        command: ["sh", "-c", "df / --output=pcent | tail -1 | tr -dc '0-9'"]

        stdout: SplitParser {
            onRead: data => {
                root.usage = parseInt(data) || 0
            }
        }
    }

    Timer {
        interval: 30000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: proc.running = true
    }

    Text {
        id: label
        anchors.verticalCenter: parent.verticalCenter
        color: Theme.cyanAlt
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        text: "󰋊 " + root.usage + "%"
    }
}
