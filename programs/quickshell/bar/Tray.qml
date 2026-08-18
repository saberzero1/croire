import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick
import qs

Item {
    id: root
    implicitWidth: trayRow.implicitWidth
    implicitHeight: trayRow.implicitHeight

    Row {
        id: trayRow
        anchors.verticalCenter: parent.verticalCenter
        spacing: Theme.barSpacing

        Repeater {
            model: SystemTray.items.values

            Item {
                required property var modelData
                implicitWidth: 16
                implicitHeight: 16

                IconImage {
                    anchors.fill: parent
                    source: modelData.icon
                    implicitWidth: 16
                    implicitHeight: 16
                }

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    onClicked: function(mouse) {
                        if (mouse.button === Qt.LeftButton)
                            modelData.activate()
                        else if (mouse.button === Qt.RightButton)
                            modelData.secondaryActivate()
                    }
                    onWheel: function(event) {
                        if (event.angleDelta.y > 0)
                            modelData.scroll(1, false)
                        else
                            modelData.scroll(-1, false)
                    }
                }
            }
        }
    }
}
