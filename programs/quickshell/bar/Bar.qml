import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: Theme.barHeight
            color: "transparent"

            RowLayout {
                anchors.fill: parent
                spacing: 0

                // ── Left pill — Workspaces ──────────────────────────────
                Rectangle {
                    color: Theme.bg
                    radius: Theme.barRadius
                    Layout.fillHeight: true
                    Layout.topMargin: Theme.barMargin
                    Layout.bottomMargin: Theme.barMargin
                    Layout.leftMargin: Theme.barMarginOuter
                    implicitWidth: workspaces.implicitWidth + 4

                    Workspaces {
                        id: workspaces
                        anchors.centerIn: parent
                    }
                }

                // ── Left spacer ─────────────────────────────────────────
                Item {
                    Layout.fillWidth: true
                }

                // ── Center pill — Clock · Date · Weather ────────────────
                Rectangle {
                    color: Theme.bg
                    radius: Theme.barRadius
                    Layout.fillHeight: true
                    Layout.topMargin: Theme.barMargin
                    Layout.bottomMargin: Theme.barMargin
                    implicitWidth: centerRow.implicitWidth + 16

                    RowLayout {
                        id: centerRow
                        anchors.centerIn: parent
                        spacing: Theme.barSpacing

                        Clock {}
                        DateModule {}
                        Weather { id: weatherWidget }
                    }
                }

                // ── Right spacer ────────────────────────────────────────
                Item {
                    Layout.fillWidth: true
                }

                // ── Right pill — System status (rainbow: red→yellow→green→cyan-alt→cyan→blue→purple) ──
                Rectangle {
                    color: Theme.bg
                    radius: Theme.barRadius
                    Layout.fillHeight: true
                    Layout.topMargin: Theme.barMargin
                    Layout.bottomMargin: Theme.barMargin
                    Layout.rightMargin: Theme.barMarginOuter
                    implicitWidth: modulesRow.implicitWidth + 4

                    RowLayout {
                        id: modulesRow
                        anchors.centerIn: parent
                        spacing: Theme.barSpacing

                        Network {}
                        Audio {}
                        Battery {}
                        Disk {}
                        Memory {}
                        Cpu {}
                        Temperature {}
                        Tray {}
                        Power {}
                    }
                }
            }
        }
    }
}
