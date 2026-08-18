import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pam
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs

Scope {
    id: root

    property string errorText: ""
    property int lockRetries: 0
    property int maxLockRetries: 5

    // Stabilization timer — wait before engaging lock
    Timer {
        id: stabilizeTimer
        interval: 500
        onTriggered: {
            sessionLock.locked = true
            retryTimer.start()
        }
    }

    // Retry timer — verify lock secured within 2s
    Timer {
        id: retryTimer
        interval: 2000
        onTriggered: {
            if (!sessionLock.secure && root.lockRetries < root.maxLockRetries) {
                root.lockRetries++
                console.warn("Lock not secure, retry", root.lockRetries, "of", root.maxLockRetries)
                sessionLock.locked = false
                stabilizeTimer.start()
            } else if (root.lockRetries >= root.maxLockRetries) {
                console.error("Lock failed after", root.maxLockRetries, "retries")
            }
        }
    }

    IpcHandler {
        target: "lock"

        function lock(): string {
            root.lockRetries = 0
            stabilizeTimer.start()
            return "locking..."
        }
    }

    PamContext {
        id: pam
        config: "login"

        onCompleted: result => {
            if (result === PamResult.Success) {
                sessionLock.locked = false
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

    WlSessionLock {
        id: sessionLock

        onSecureChanged: {
            if (secure) {
                retryTimer.stop()
                console.log("Lock secured successfully")
            }
        }

        WlSessionLockSurface {
            color: Theme.bgDark

            // Background wallpaper
            Image {
                anchors.fill: parent
                source: "file://" + Quickshell.env("HOME") + "/.assets/backgrounds/wallpaper_night.png"
                fillMode: Image.PreserveAspectCrop
            }

            // Dark overlay
            Rectangle {
                anchors.fill: parent
                color: Theme.bgDark
                opacity: 0.6
            }

            // Lock screen content
            ColumnLayout {
                anchors.centerIn: parent
                spacing: 20

                // Time
                Text {
                    Layout.alignment: Qt.AlignHCenter
                    color: Theme.fg
                    font.family: Theme.fontFamilyDisplay
                    font.pixelSize: 100
                    text: Qt.formatDateTime(new Date(), "HH:mm")

                    Timer {
                        interval: 1000
                        running: sessionLock.locked
                        repeat: true
                        onTriggered: parent.text = Qt.formatDateTime(new Date(), "HH:mm")
                    }
                }

                // Date
                Text {
                    Layout.alignment: Qt.AlignHCenter
                    color: Theme.fg
                    font.family: Theme.fontFamilyDisplay
                    font.pixelSize: 25
                    text: Qt.formatDateTime(new Date(), "dddd, dd MMMM")

                    Timer {
                        interval: 60000
                        running: sessionLock.locked
                        repeat: true
                        onTriggered: parent.text = Qt.formatDateTime(new Date(), "dddd, dd MMMM")
                    }
                }

                Item { height: 40 }

                // Password input
                Rectangle {
                    Layout.alignment: Qt.AlignHCenter
                    width: 400
                    height: 50
                    color: Theme.bg
                    border.color: Theme.blue
                    border.width: 2
                    radius: 5

                    TextInput {
                        id: passwordInput
                        anchors.fill: parent
                        anchors.margins: 10
                        color: Theme.fg
                        font.family: Theme.fontFamilyDisplay
                        font.pixelSize: 16
                        echoMode: TextInput.Password
                        passwordCharacter: "●"
                        clip: true

                        Text {
                            anchors.fill: parent
                            color: Theme.comment
                            font.family: parent.font.family
                            font.pixelSize: parent.font.pixelSize
                            font.italic: true
                            text: "Password..."
                            visible: !parent.text && !parent.activeFocus
                            verticalAlignment: Text.AlignVCenter
                        }

                        Keys.onReturnPressed: {
                            if (text.length > 0) {
                                pam.start()
                                pam.respond(text)
                                text = ""
                            }
                        }
                    }
                }

                // Error text
                Text {
                    Layout.alignment: Qt.AlignHCenter
                    color: Theme.red
                    font.family: Theme.fontFamily
                    font.pixelSize: 14
                    text: root.errorText
                    visible: root.errorText !== ""
                }
            }

            // Click anywhere to focus password field
            MouseArea {
                anchors.fill: parent
                onClicked: passwordInput.forceActiveFocus()
                z: -1
            }
        }
    }
}
