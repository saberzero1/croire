import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs

Scope {
    id: root

    property bool running: false
    property string status: "idle"
    property string downloadSpeed: "--"
    property string uploadSpeed: "--"
    property string ping: "--"
    property string server: ""
    property string resultJson: ""

    PanelController { id: ctrl }

    IpcHandler {
        target: "speedtest"

        function run(): string {
            ctrl.show()
            root.startTest()
            return "running..."
        }

        function toggle(): string { ctrl.toggle(); return ctrl.open ? "opened" : "closed" }

        function results(): string {
            if (root.status === "idle") return "no results — run a test first"
            if (root.running) return "test in progress..."
            return "down=" + root.downloadSpeed + " up=" + root.uploadSpeed + " ping=" + root.ping
        }
    }

    Process {
        id: speedtestProc
        command: ["speedtest-cli", "--json"]
        stdout: SplitParser {
            splitMarker: ""
            onRead: data => {
                root.resultJson += data.toString()
            }
        }
        onExited: (exitCode, exitStatus) => {
            root.running = false
            if (exitCode === 0) {
                root.parseResults(root.resultJson)
            } else {
                root.status = "error"
                root.startFallback()
            }
        }
    }

    // Fallback: curl-based download test
    Process {
        id: fallbackDownProc
        command: ["curl", "-o", "/dev/null", "-w", "%{speed_download}", "-s",
                  "https://speed.cloudflare.com/__down?bytes=10000000"]
        stdout: SplitParser {
            splitMarker: ""
            onRead: data => {
                var speed = parseFloat(data.toString().trim())
                if (!isNaN(speed)) {
                    root.downloadSpeed = (speed / 125000).toFixed(2) + " Mbps"
                }
                root.status = "Testing upload..."
                fallbackUpProc.running = true
            }
        }
    }

    Process {
        id: fallbackUpProc
        command: ["curl", "-X", "POST", "-o", "/dev/null", "-w", "%{speed_upload}", "-s",
                  "--data-binary", "@/dev/zero", "--max-time", "5",
                  "https://speed.cloudflare.com/__up"]
        stdout: SplitParser {
            splitMarker: ""
            onRead: data => {
                var speed = parseFloat(data.toString().trim())
                if (!isNaN(speed)) {
                    root.uploadSpeed = (speed / 125000).toFixed(2) + " Mbps"
                }
            }
        }
        onExited: {
            root.running = false
            root.status = "done"
            // Ping via a simple approach
            pingProc.running = true
        }
    }

    Process {
        id: pingProc
        command: ["ping", "-c", "3", "-q", "1.1.1.1"]
        stdout: SplitParser {
            onRead: data => {
                var line = data.toString()
                // Parse "rtt min/avg/max/mdev = X/Y/Z/W ms"
                var match = line.match(/= [\d.]+\/([\d.]+)\//)
                if (match) {
                    root.ping = parseFloat(match[1]).toFixed(1) + " ms"
                }
            }
        }
    }

    function startTest() {
        root.running = true
        root.status = "Testing..."
        root.downloadSpeed = "--"
        root.uploadSpeed = "--"
        root.ping = "--"
        root.server = ""
        root.resultJson = ""
        speedtestProc.running = true
    }

    function startFallback() {
        root.running = true
        root.status = "Testing download..."
        fallbackDownProc.running = true
    }

    function parseResults(raw) {
        try {
            var json = JSON.parse(raw)
            root.downloadSpeed = (json.download / 1000000).toFixed(2) + " Mbps"
            root.uploadSpeed = (json.upload / 1000000).toFixed(2) + " Mbps"
            root.ping = json.ping.toFixed(1) + " ms"
            root.server = json.server ? json.server.name : ""
            root.status = "done"
        } catch (e) {
            root.status = "parse error"
            root.startFallback()
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

            anchors { top: true; bottom: true; left: true; right: true }
            exclusionMode: ExclusionMode.Ignore

            MouseArea { anchors.fill: parent; onClicked: ctrl.hide() }

            Rectangle {
                anchors.centerIn: parent
                width: 380; height: 300
                color: Theme.bg; radius: Theme.barRadius
                border.color: Theme.border; border.width: 1

                ColumnLayout {
                    anchors.fill: parent; anchors.margins: 16; spacing: 12

                    // Header
                    RowLayout {
                        Layout.fillWidth: true
                        Text {
                            color: Theme.fg; font.family: Theme.fontFamily
                            font.pixelSize: 16; font.bold: true
                            text: "Speed Test"
                        }
                        Item { Layout.fillWidth: true }
                        // Run button
                        Rectangle {
                            width: runLabel.implicitWidth + 16; height: 24
                            color: root.running ? Theme.comment : Theme.blue
                            radius: 4; opacity: root.running ? 0.5 : 1.0

                            Text {
                                id: runLabel; anchors.centerIn: parent
                                color: Theme.bgDark; font.family: Theme.fontFamily
                                font.pixelSize: 11; font.bold: true
                                text: root.running ? "Running..." : "Run Test"
                            }
                            MouseArea {
                                anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                                enabled: !root.running
                                onClicked: root.startTest()
                            }
                        }
                    }

                    // Status
                    Text {
                        Layout.fillWidth: true; visible: root.running
                        color: Theme.cyan; font.family: Theme.fontFamily
                        font.pixelSize: 11
                        text: root.status
                    }

                    // Results
                    ColumnLayout {
                        Layout.fillWidth: true; Layout.fillHeight: true; spacing: 16

                        // Download
                        ColumnLayout {
                            Layout.fillWidth: true; spacing: 4

                            Text {
                                color: Theme.comment; font.family: Theme.fontFamily
                                font.pixelSize: 11; text: "DOWNLOAD"
                            }
                            Text {
                                color: Theme.green; font.family: Theme.fontFamily
                                font.pixelSize: 24; font.bold: true
                                text: root.downloadSpeed
                            }
                        }

                        // Upload
                        ColumnLayout {
                            Layout.fillWidth: true; spacing: 4

                            Text {
                                color: Theme.comment; font.family: Theme.fontFamily
                                font.pixelSize: 11; text: "UPLOAD"
                            }
                            Text {
                                color: Theme.blue; font.family: Theme.fontFamily
                                font.pixelSize: 24; font.bold: true
                                text: root.uploadSpeed
                            }
                        }

                        // Ping
                        RowLayout {
                            Layout.fillWidth: true; spacing: 20

                            ColumnLayout {
                                spacing: 4
                                Text { color: Theme.comment; font.family: Theme.fontFamily; font.pixelSize: 11; text: "PING" }
                                Text { color: Theme.yellow; font.family: Theme.fontFamily; font.pixelSize: 16; font.bold: true; text: root.ping }
                            }

                            ColumnLayout {
                                spacing: 4; visible: root.server !== ""
                                Text { color: Theme.comment; font.family: Theme.fontFamily; font.pixelSize: 11; text: "SERVER" }
                                Text { color: Theme.fg; font.family: Theme.fontFamily; font.pixelSize: 11; text: root.server }
                            }
                        }

                        Item { Layout.fillHeight: true }
                    }
                }
            }

            Keys.onEscapePressed: ctrl.hide()
        }
    }
}
