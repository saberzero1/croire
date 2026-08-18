import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs

Scope {
    id: root

    property var weatherData: null
    property string compactText: ""
    property real lastUpdate: 0
    property bool loading: false

    PanelController { id: ctrl }

    IpcHandler {
        target: "weather"

        function toggle(): string { ctrl.toggle(); return ctrl.open ? "opened" : "closed" }

        function refresh(): string { root.fetchWeather(); return "refreshing..." }

        function compact(): string { return root.compactText || "no data" }
    }

    // Fetch weather every 30 minutes
    Timer {
        interval: 1800000; running: true; repeat: true
        triggeredOnStart: true
        onTriggered: root.fetchWeather()
    }

    Process {
        id: weatherProc
        command: ["curl", "-s", "https://wttr.in/?format=j1"]
        stdout: StdioCollector {
            waitForEnd: true
            onStreamFinished: root.parseWeather(text)
        }
    }

    function fetchWeather() {
        if (loading) return
        loading = true
        weatherProc.running = true
    }

    function conditionIcon(code) {
        var c = parseInt(code)
        if (c === 113) return "\u{2600}\u{FE0F}"       // sunny
        if (c === 116) return "\u{26C5}"               // partly cloudy
        if (c === 119 || c === 122) return "\u{2601}\u{FE0F}" // cloudy/overcast
        if (c === 143 || c === 248 || c === 260) return "\u{1F32B}\u{FE0F}" // fog/mist
        if (c === 176 || c === 263 || c === 266) return "\u{1F326}\u{FE0F}" // light rain
        if (c === 293 || c === 296 || c === 299 || c === 302) return "\u{1F327}\u{FE0F}" // rain
        if (c === 305 || c === 308 || c === 356 || c === 359) return "\u{1F327}\u{FE0F}" // heavy rain
        if (c === 179 || c === 323 || c === 326) return "\u{1F328}\u{FE0F}" // light snow
        if (c === 227 || c === 329 || c === 332 || c === 335 || c === 338) return "\u{2744}\u{FE0F}" // snow
        if (c === 200 || c === 386 || c === 389) return "\u{26C8}\u{FE0F}" // thunderstorm
        if (c === 182 || c === 185 || c === 311 || c === 314) return "\u{1F9CA}" // sleet/ice
        return "\u{1F324}\u{FE0F}" // default
    }

    function parseWeather(raw) {
        loading = false
        try {
            var json = JSON.parse(raw)
            var current = json.current_condition[0]
            var area = json.nearest_area[0]

            root.weatherData = {
                location: area.areaName[0].value + ", " + area.country[0].value,
                tempC: current.temp_C,
                condition: current.weatherDesc[0].value,
                conditionCode: current.weatherCode,
                humidity: current.humidity,
                windSpeed: current.windspeedKmph,
                windDir: current.winddir16Point,
                feelsLike: current.FeelsLikeC,
                visibility: current.visibility,
                pressure: current.pressure
            }

            var icon = conditionIcon(current.weatherCode)
            root.compactText = icon + " " + current.temp_C + "\u{00B0}C"
            root.lastUpdate = Date.now()
        } catch (e) {
            console.warn("Weather parse error:", e)
        }
    }

    function timeSinceUpdate() {
        if (lastUpdate === 0) return "never"
        var mins = Math.round((Date.now() - lastUpdate) / 60000)
        if (mins < 1) return "just now"
        if (mins === 1) return "1 min ago"
        return mins + " min ago"
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
                width: 360; height: 320
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
                            text: "Weather"
                        }
                        Item { Layout.fillWidth: true }
                        // Refresh button
                        Text {
                            color: Theme.comment; font.family: Theme.fontFamily
                            font.pixelSize: 13; text: "\u{21BB}"
                            MouseArea {
                                anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                                onClicked: root.fetchWeather()
                            }
                        }
                    }

                    // Loading / No data state
                    Text {
                        Layout.fillWidth: true; Layout.fillHeight: true
                        visible: root.weatherData === null
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: Theme.comment; font.family: Theme.fontFamily
                        font.pixelSize: 13
                        text: root.loading ? "Loading..." : "No weather data"
                    }

                    // Weather content
                    ColumnLayout {
                        Layout.fillWidth: true; Layout.fillHeight: true
                        visible: root.weatherData !== null; spacing: 10

                        // Location
                        Text {
                            Layout.fillWidth: true
                            color: Theme.comment; font.family: Theme.fontFamily
                            font.pixelSize: 11
                            text: root.weatherData ? root.weatherData.location : ""
                        }

                        // Temperature + condition
                        RowLayout {
                            Layout.fillWidth: true; spacing: 12
                            Text {
                                font.pixelSize: 36
                                text: root.weatherData ? root.conditionIcon(root.weatherData.conditionCode) : ""
                            }
                            ColumnLayout {
                                spacing: 2
                                Text {
                                    color: Theme.fg; font.family: Theme.fontFamily
                                    font.pixelSize: 28; font.bold: true
                                    text: root.weatherData ? root.weatherData.tempC + "\u{00B0}C" : ""
                                }
                                Text {
                                    color: Theme.comment; font.family: Theme.fontFamily
                                    font.pixelSize: 11
                                    text: root.weatherData ? "Feels like " + root.weatherData.feelsLike + "\u{00B0}C" : ""
                                }
                            }
                        }

                        // Condition text
                        Text {
                            Layout.fillWidth: true
                            color: Theme.fg; font.family: Theme.fontFamily
                            font.pixelSize: 13
                            text: root.weatherData ? root.weatherData.condition : ""
                        }

                        // Details grid
                        GridLayout {
                            Layout.fillWidth: true
                            columns: 2; rowSpacing: 6; columnSpacing: 20

                            Text { color: Theme.comment; font.family: Theme.fontFamily; font.pixelSize: 11; text: "Humidity" }
                            Text { color: Theme.fg; font.family: Theme.fontFamily; font.pixelSize: 11; text: root.weatherData ? root.weatherData.humidity + "%" : "" }

                            Text { color: Theme.comment; font.family: Theme.fontFamily; font.pixelSize: 11; text: "Wind" }
                            Text { color: Theme.fg; font.family: Theme.fontFamily; font.pixelSize: 11; text: root.weatherData ? root.weatherData.windSpeed + " km/h " + root.weatherData.windDir : "" }

                            Text { color: Theme.comment; font.family: Theme.fontFamily; font.pixelSize: 11; text: "Visibility" }
                            Text { color: Theme.fg; font.family: Theme.fontFamily; font.pixelSize: 11; text: root.weatherData ? root.weatherData.visibility + " km" : "" }

                            Text { color: Theme.comment; font.family: Theme.fontFamily; font.pixelSize: 11; text: "Pressure" }
                            Text { color: Theme.fg; font.family: Theme.fontFamily; font.pixelSize: 11; text: root.weatherData ? root.weatherData.pressure + " hPa" : "" }
                        }

                        Item { Layout.fillHeight: true }

                        // Footer
                        Text {
                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignRight
                            color: Theme.comment; font.family: Theme.fontFamily
                            font.pixelSize: 9
                            text: "Updated " + root.timeSinceUpdate()
                        }
                    }
                }
            }

            Keys.onEscapePressed: ctrl.hide()
        }
    }
}
