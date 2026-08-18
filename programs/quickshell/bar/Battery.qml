import Quickshell
import Quickshell.Services.UPower
import QtQuick
import qs

Item {
    id: root
    visible: UPower.displayDevice.isLaptopBattery
    implicitWidth: visible ? container.implicitWidth : 0
    implicitHeight: visible ? container.implicitHeight : 0

    property real percentage: UPower.displayDevice.percentage
    property bool charging: UPower.displayDevice.state === UPowerDeviceState.Charging
                         || UPower.displayDevice.state === UPowerDeviceState.PendingCharge
    property bool full: UPower.displayDevice.state === UPowerDeviceState.FullyCharged
    property bool warning: percentage <= 0.3 && !charging && !full

    property string icon: {
        if (full) return "󰂅"
        if (charging) return "󰂄"
        return "󰁹"
    }

    Rectangle {
        id: container
        implicitWidth: label.implicitWidth + (root.warning ? 10 : 0)
        implicitHeight: label.implicitHeight + (root.warning ? 6 : 0)
        color: root.warning ? Theme.red : "transparent"
        radius: root.warning ? Theme.barRadius : 0

        Text {
            id: label
            anchors.centerIn: parent
            color: root.warning ? Theme.bg : Theme.green
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize
            text: root.icon + " " + Math.round(root.percentage * 100) + "%"
        }
    }
}
