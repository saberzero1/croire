import Quickshell
import Quickshell.Io
import Quickshell.Services.Pam
import QtQuick
import QtQuick.Layouts
import qs

Scope {
    id: root

    PanelController { id: ctrl }
    property string actionMessage: ""
    property string errorText: ""

    // Polkit agent — listens for auth requests
    // Note: Quickshell.Services.Polkit.PolkitAgent may need to be used
    // when available. For now, this provides a PAM-based auth dialog
    // that can be triggered via IPC.

    IpcHandler {
        target: "polkit"

        function authenticate(message: string): string {
            root.actionMessage = message || "Authentication required"
            ctrl.show()
            root.errorText = ""
            return "dialog opened"
        }
    }

    PamContext {
        id: pam
        config: "login"

        onCompleted: result => {
            if (result === PamResult.Success) {
                ctrl.hide()
                root.errorText = ""
            } else {
                root.errorText = "Authentication failed"
            }
        }

        onPamMessage: {
            if (pam.messageIsError) {
                root.errorText = pam.message
            }
        }
    }

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

            // Dimmed backdrop
            Rectangle {
                anchors.fill: parent
                color: Theme.bgDark
                opacity: 0.6
            }

            // Auth dialog
            Rectangle {
                anchors.centerIn: parent
                width: 400
                height: authLayout.implicitHeight + 40
                color: Theme.bg
                border.color: Theme.border
                border.width: 2
                radius: Theme.barRadius * 2

                ColumnLayout {
                    id: authLayout
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 12

                    // Lock icon
                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        color: Theme.yellow
                        font.family: Theme.fontFamily
                        font.pixelSize: 32
                        text: "󰌾"
                    }

                    // Title
                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        color: Theme.fg
                        font.family: Theme.fontFamily
                        font.pixelSize: 16
                        font.bold: true
                        text: "Authentication Required"
                    }

                    // Message
                    Text {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignHCenter
                        color: Theme.comment
                        font.family: Theme.fontFamily
                        font.pixelSize: 12
                        text: root.actionMessage
                        wrapMode: Text.Wrap
                        horizontalAlignment: Text.AlignHCenter
                    }

                    // Password input
                    Rectangle {
                        Layout.fillWidth: true
                        height: 40
                        color: Theme.bgDark
                        border.color: Theme.border
                        border.width: 1
                        radius: 4

                        TextInput {
                            id: polkitPassword
                            anchors.fill: parent
                            anchors.margins: 8
                            color: Theme.fg
                            font.family: Theme.fontFamily
                            font.pixelSize: 14
                            echoMode: TextInput.Password
                            passwordCharacter: "●"
                            clip: true

                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                color: Theme.comment
                                font: parent.font
                                text: "Password..."
                                visible: !parent.text && !parent.activeFocus
                            }

                            Keys.onReturnPressed: {
                                if (text.length > 0) {
                                    pam.start()
                                    pam.respond(text)
                                    text = ""
                                }
                            }

                            Keys.onEscapePressed: {
                                ctrl.hide()
                            }
                        }
                    }

                    // Error
                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        visible: root.errorText !== ""
                        color: Theme.red
                        font.family: Theme.fontFamily
                        font.pixelSize: 12
                        text: root.errorText
                    }

                    // Buttons
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 8

                        Item { Layout.fillWidth: true }

                        // Cancel
                        Rectangle {
                            implicitWidth: cancelText.implicitWidth + 24
                            implicitHeight: 32
                            color: cancelMouse.containsMouse ? Theme.border : "transparent"
                            border.color: Theme.border
                            border.width: 1
                            radius: 4

                            Text {
                                id: cancelText
                                anchors.centerIn: parent
                                color: Theme.fg
                                font.family: Theme.fontFamily
                                font.pixelSize: 12
                                text: "Cancel"
                            }

                            MouseArea {
                                id: cancelMouse
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: ctrl.hide()
                            }
                        }

                        // Authenticate
                        Rectangle {
                            implicitWidth: authText.implicitWidth + 24
                            implicitHeight: 32
                            color: authMouse.containsMouse ? Theme.cyan : Theme.blue
                            radius: 4

                            Text {
                                id: authText
                                anchors.centerIn: parent
                                color: Theme.bgDark
                                font.family: Theme.fontFamily
                                font.pixelSize: 12
                                font.bold: true
                                text: "Authenticate"
                            }

                            MouseArea {
                                id: authMouse
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    if (polkitPassword.text.length > 0) {
                                        pam.start()
                                        pam.respond(polkitPassword.text)
                                        polkitPassword.text = ""
                                    }
                                }
                            }
                        }
                    }
                }
            }

            onVisibleChanged: {
                if (visible) polkitPassword.forceActiveFocus()
            }
        }
    }
}
