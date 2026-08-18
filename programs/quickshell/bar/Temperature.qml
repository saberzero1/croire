import Quickshell
import Quickshell.Io
import QtQuick
import qs

Item {
    id: root
    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitHeight

    property int temp: 0

    Process {
        id: proc
        command: ["sh", "-c", "cat /sys/class/thermal/thermal_zone0/temp 2>/dev/null | awk '{printf \"%d\", $1/1000}'"]

        stdout: SplitParser {
            onRead: data => {
                root.temp = parseInt(data) || 0
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
        color: Theme.purple
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        text: "󰔏 " + root.temp + "°C"
    }
}
