import Quickshell
import QtQuick
import qs

Scope {
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

            color: Theme.bgDark
            exclusionMode: ExclusionMode.Ignore
            aboveWindows: false

            Image {
                anchors.fill: parent
                source: "file://" + Quickshell.env("HOME") + "/.assets/backgrounds/wallpaper_pixel_neon.png"
                fillMode: Image.PreserveAspectCrop
            }
        }
    }
}
