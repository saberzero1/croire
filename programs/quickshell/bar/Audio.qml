import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import qs

Item {
    id: root
    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitHeight

    property var node: Pipewire.defaultAudioSink

    PwObjectTracker {
        objects: [root.node]
    }

    property real volume: root.node && root.node.audio ? root.node.audio.volume : 0
    property bool muted: root.node && root.node.audio ? root.node.audio.muted : false

    property string icon: {
        if (root.muted) return "󰖁"
        if (root.volume < 0.33) return "󰕿"
        if (root.volume < 0.66) return "󰖀"
        return "󰕾"
    }

    Text {
        id: label
        anchors.verticalCenter: parent.verticalCenter
        color: Theme.yellow
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        text: root.muted ? "󰖁 Muted" : root.icon + "  " + Math.round(root.volume * 100) + "%"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (root.node && root.node.audio) {
                root.node.audio.muted = !root.node.audio.muted
            }
        }
    }
}
