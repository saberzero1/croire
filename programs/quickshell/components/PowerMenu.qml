import Quickshell
import Quickshell.Io
import QtQuick
import qs

Scope {
    id: root

    PanelController { id: ctrl }

    IpcHandler {
        target: "power"
        function toggle(): string { ctrl.toggle(); return ctrl.open ? "opened" : "closed" }
    }

    function runAction(action) {
        ctrl.hide()
        switch (action) {
            case "lock":     lockProc.running = true; break
            case "suspend":  suspendProc.running = true; break
            case "logout":   logoutProc.running = true; break
            case "reboot":   rebootProc.running = true; break
            case "shutdown": poweroffProc.running = true; break
        }
    }

    Process { id: poweroffProc; command: ["systemctl", "poweroff"] }
    Process { id: rebootProc; command: ["systemctl", "reboot"] }
    Process { id: suspendProc; command: ["systemctl", "suspend"] }
    Process { id: lockProc; command: ["loginctl", "lock-session"] }
    Process { id: logoutProc; command: ["loginctl", "terminate-user", Quickshell.env("USER")] }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            visible: ctrl.open
            focusable: true
            color: "transparent"

            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }

            exclusionMode: ExclusionMode.Ignore

            // Click outside to close
            MouseArea {
                anchors.fill: parent
                onClicked: ctrl.hide()
            }

            // Menu card positioned top-right below bar
            Rectangle {
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.topMargin: Theme.barHeight + 4
                anchors.rightMargin: Theme.barMarginOuter

                width: 160
                height: menuColumn.implicitHeight + 12
                color: Theme.bg
                radius: Theme.barRadius
                border.color: Theme.border
                border.width: 1

                Column {
                    id: menuColumn
                    anchors.fill: parent
                    anchors.margins: 4
                    spacing: 2

                    component PowerMenuItem: Rectangle {
                        property string icon
                        property string label
                        property string action
                        property bool isDanger: false

                        width: parent.width
                        height: 32
                        color: pmMouse.containsMouse ? Theme.border : "transparent"
                        radius: 4

                        Row {
                            anchors.fill: parent
                            anchors.leftMargin: 10
                            spacing: 8

                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                color: parent.parent.isDanger ? Theme.red : Theme.fg
                                font.family: Theme.fontFamily
                                font.pixelSize: 14
                                text: parent.parent.icon
                            }

                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                color: parent.parent.isDanger ? Theme.red : Theme.fg
                                font.family: Theme.fontFamily
                                font.pixelSize: 12
                                text: parent.parent.label
                            }
                        }

                        MouseArea {
                            id: pmMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: root.runAction(parent.action)
                        }
                    }

                    PowerMenuItem { icon: "󰌾"; label: "Lock";     action: "lock" }
                    PowerMenuItem { icon: "󰤄"; label: "Suspend";  action: "suspend" }
                    PowerMenuItem { icon: "󰍃"; label: "Logout";   action: "logout" }
                    PowerMenuItem { icon: "󰜉"; label: "Reboot";   action: "reboot" }
                    PowerMenuItem { icon: "󰐥"; label: "Shutdown"; action: "shutdown"; isDanger: true }
                }
            }

            Keys.onEscapePressed: ctrl.hide()
        }
    }
}
