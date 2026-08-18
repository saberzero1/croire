import Quickshell
import Quickshell.Io
import QtQuick
import qs

Item {
    id: root
    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitHeight

    property string compactText: ""

    Process {
        id: weatherProc
        command: ["curl", "-s", "https://wttr.in/?format=%c+%t"]
        stdout: StdioCollector {
            waitForEnd: true
            onStreamFinished: {
                var result = text.toString().trim()
                if (result && !result.startsWith("Unknown") && !result.startsWith("<"))
                    root.compactText = result
            }
        }
    }

    Timer {
        interval: 1800000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: weatherProc.running = true
    }

    Text {
        id: label
        anchors.verticalCenter: parent.verticalCenter
        color: Theme.fg
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        text: root.compactText || "..."
        visible: root.compactText !== ""
    }
}
