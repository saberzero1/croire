import Quickshell
import Quickshell.Io
import QtQuick
import qs

Scope {
    id: root

    property bool enabled: false
    property bool autoMode: true
    property int temperature: 4000
    property int sunriseHour: 8
    property int sunriseMinute: 0
    property int sunsetHour: 18
    property int sunsetMinute: 0

    IpcHandler {
        target: "nightlight"

        function toggle(): string {
            if (root.enabled) {
                root.disable()
                return "disabled"
            } else {
                root.enable()
                return "enabled (" + root.temperature + "K)"
            }
        }

        function set(temp: string): string {
            var t = parseInt(temp)
            if (isNaN(t) || t < 1000 || t > 10000) return "error: temperature must be 1000-10000"
            root.temperature = t
            if (root.enabled) root.enable()
            return "temperature set to " + t + "K"
        }

        function auto(mode: string): string {
            if (mode === "on") {
                root.autoMode = true
                return "auto mode enabled (sunrise " + root.sunriseHour + ":00, sunset " + root.sunsetHour + ":00)"
            } else if (mode === "off") {
                root.autoMode = false
                return "auto mode disabled"
            }
            return "auto mode: " + (root.autoMode ? "on" : "off")
        }

        function status(): string {
            return "enabled=" + root.enabled + " temp=" + root.temperature +
                   "K auto=" + root.autoMode + " sunrise=" + root.sunriseHour +
                   ":00 sunset=" + root.sunsetHour + ":00"
        }
    }

    Process { id: nightlightProc }
    Process { id: killProc }

    function enable() {
        // Kill any existing hyprsunset first, then start new one
        killProc.command = ["pkill", "-x", "hyprsunset"]
        killProc.running = true
        startTimer.restart()
    }

    // Small delay to let pkill finish before starting new process
    Timer {
        id: startTimer; interval: 200; repeat: false
        onTriggered: {
            nightlightProc.command = ["hyprsunset", "-t", root.temperature.toString()]
            nightlightProc.running = true
            root.enabled = true
        }
    }

    function disable() {
        killProc.command = ["pkill", "-x", "hyprsunset"]
        killProc.running = true
        root.enabled = false
    }

    // Check if hyprsunset is available
    property bool hyprsunsetAvailable: false
    Process {
        id: checkProc
        command: ["which", "hyprsunset"]
        onExited: function(code) { root.hyprsunsetAvailable = (code === 0) }
    }
    Component.onCompleted: checkProc.running = true

    // Auto mode: check every 60 seconds (only if hyprsunset is available)
    Timer {
        interval: 60000; running: root.autoMode && root.hyprsunsetAvailable; repeat: true
        triggeredOnStart: true
        onTriggered: {
            var now = new Date()
            var hour = now.getHours()
            var minute = now.getMinutes()
            var currentMinutes = hour * 60 + minute
            var sunriseMinutes = root.sunriseHour * 60 + root.sunriseMinute
            var sunsetMinutes = root.sunsetHour * 60 + root.sunsetMinute

            var shouldBeNight = currentMinutes < sunriseMinutes || currentMinutes >= sunsetMinutes

            if (shouldBeNight && !root.enabled) {
                root.enable()
            } else if (!shouldBeNight && root.enabled) {
                root.disable()
            }
        }
    }
}
