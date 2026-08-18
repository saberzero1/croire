import Quickshell
import Quickshell.Services.Greetd
import QtQuick
import QtQuick.Layouts
// Qt5Compat.GraphicalEffects removed — using simple overlay instead

ShellRoot {
    id: root

    property string errorText: ""
    property string selectedSession: "hyprland-uwsm"
    property bool authenticating: false

    Greetd {
        id: greetd

        onSuccess: {
            root.authenticating = false
            root.errorText = ""
        }

        onError: message => {
            root.authenticating = false
            root.errorText = message || "Authentication failed"
        }

        onAuthMessage: (message, isError) => {
            if (isError) {
                root.errorText = message
            }
        }
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }

            color: "#1a1b26"
            focusable: true

            // Background
            Image {
                anchors.fill: parent
                source: "file:///etc/quickshell-greeter/wallpaper.png"
                fillMode: Image.PreserveAspectCrop
            }

            Rectangle {
                anchors.fill: parent
                color: "#1a1b26"
                opacity: 0.6
            }

            // Login form
            ColumnLayout {
                anchors.centerIn: parent
                spacing: 20
                width: 420

                // Time
                Text {
                    Layout.alignment: Qt.AlignHCenter
                    color: "#c0caf5"
                    font.family: "Monaspace Neon"
                    font.pixelSize: 80
                    text: Qt.formatDateTime(new Date(), "HH:mm")

                    Timer {
                        interval: 1000
                        running: true
                        repeat: true
                        onTriggered: parent.text = Qt.formatDateTime(new Date(), "HH:mm")
                    }
                }

                // Date
                Text {
                    Layout.alignment: Qt.AlignHCenter
                    color: "#c0caf5"
                    font.family: "Monaspace Neon"
                    font.pixelSize: 20
                    text: Qt.formatDateTime(new Date(), "dddd, dd MMMM yyyy")

                    Timer {
                        interval: 60000
                        running: true
                        repeat: true
                        onTriggered: parent.text = Qt.formatDateTime(new Date(), "dddd, dd MMMM yyyy")
                    }
                }

                Item { height: 30 }

                // Username
                Rectangle {
                    Layout.fillWidth: true
                    height: 44
                    color: "#24283b"
                    border.color: "#414868"
                    border.width: 1
                    radius: 5

                    TextInput {
                        id: usernameInput
                        anchors.fill: parent
                        anchors.margins: 10
                        color: "#c0caf5"
                        font.family: "mononoki Nerd Font"
                        font.pixelSize: 14
                        clip: true
                        text: "saberzero1"

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            color: "#565f89"
                            font: parent.font
                            text: "Username"
                            visible: !parent.text && !parent.activeFocus
                        }

                        Keys.onTabPressed: passwordInput.forceActiveFocus()
                    }
                }

                // Password
                Rectangle {
                    Layout.fillWidth: true
                    height: 44
                    color: "#24283b"
                    border.color: "#7aa2f7"
                    border.width: 2
                    radius: 5

                    TextInput {
                        id: passwordInput
                        anchors.fill: parent
                        anchors.margins: 10
                        color: "#c0caf5"
                        font.family: "mononoki Nerd Font"
                        font.pixelSize: 14
                        echoMode: TextInput.Password
                        passwordCharacter: "●"
                        clip: true

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            color: "#565f89"
                            font: parent.font
                            font.italic: true
                            text: "Password..."
                            visible: !parent.text && !parent.activeFocus
                        }

                        Keys.onReturnPressed: {
                            if (usernameInput.text && passwordInput.text) {
                                root.authenticating = true
                                root.errorText = ""
                                greetd.login(usernameInput.text, passwordInput.text, [root.selectedSession])
                            }
                        }
                    }
                }

                // Error
                Text {
                    Layout.alignment: Qt.AlignHCenter
                    visible: root.errorText !== ""
                    color: "#f7768e"
                    font.family: "mononoki Nerd Font"
                    font.pixelSize: 12
                    text: root.errorText
                }

                // Login button
                Rectangle {
                    Layout.fillWidth: true
                    height: 40
                    color: loginMouse.containsMouse ? "#7dcfff" : "#7aa2f7"
                    radius: 5

                    Text {
                        anchors.centerIn: parent
                        color: "#1a1b26"
                        font.family: "mononoki Nerd Font"
                        font.pixelSize: 14
                        font.bold: true
                        text: root.authenticating ? "Logging in..." : "Login"
                    }

                    MouseArea {
                        id: loginMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            if (usernameInput.text && passwordInput.text && !root.authenticating) {
                                root.authenticating = true
                                root.errorText = ""
                                greetd.login(usernameInput.text, passwordInput.text, [root.selectedSession])
                            }
                        }
                    }
                }

                // Session selector
                Text {
                    Layout.alignment: Qt.AlignHCenter
                    color: "#565f89"
                    font.family: "mononoki Nerd Font"
                    font.pixelSize: 11
                    text: "Session: " + root.selectedSession
                }
            }

            Component.onCompleted: passwordInput.forceActiveFocus()
        }
    }
}
