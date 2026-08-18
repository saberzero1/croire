import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs

Scope {
    id: root

    property string filterText: ""

    PanelController { id: ctrl }

    IpcHandler {
        target: "emoji"
        function toggle(): string { ctrl.toggle(); return ctrl.open ? "opened" : "closed" }
    }

    // Curated emoji list (~200 common emojis)
    readonly property var emojiData: [
        // Smileys & Emotion
        {emoji: "\u{1F600}", name: "grinning face"},
        {emoji: "\u{1F603}", name: "smiley"},
        {emoji: "\u{1F604}", name: "smile"},
        {emoji: "\u{1F601}", name: "beaming face"},
        {emoji: "\u{1F606}", name: "laughing"},
        {emoji: "\u{1F605}", name: "sweat smile"},
        {emoji: "\u{1F923}", name: "rolling on floor laughing"},
        {emoji: "\u{1F602}", name: "joy tears"},
        {emoji: "\u{1F642}", name: "slightly smiling"},
        {emoji: "\u{1F643}", name: "upside down"},
        {emoji: "\u{1F609}", name: "wink"},
        {emoji: "\u{1F60A}", name: "blush"},
        {emoji: "\u{1F607}", name: "innocent halo"},
        {emoji: "\u{1F970}", name: "smiling with hearts"},
        {emoji: "\u{1F60D}", name: "heart eyes"},
        {emoji: "\u{1F929}", name: "star struck"},
        {emoji: "\u{1F618}", name: "kissing heart"},
        {emoji: "\u{1F617}", name: "kissing"},
        {emoji: "\u{1F61A}", name: "kissing closed eyes"},
        {emoji: "\u{1F60B}", name: "yummy tongue"},
        {emoji: "\u{1F61B}", name: "tongue out"},
        {emoji: "\u{1F61C}", name: "winking tongue"},
        {emoji: "\u{1F92A}", name: "zany face"},
        {emoji: "\u{1F61D}", name: "squinting tongue"},
        {emoji: "\u{1F911}", name: "money mouth"},
        {emoji: "\u{1F917}", name: "hugging"},
        {emoji: "\u{1F92D}", name: "hand over mouth"},
        {emoji: "\u{1F92B}", name: "shushing"},
        {emoji: "\u{1F914}", name: "thinking"},
        {emoji: "\u{1F910}", name: "zipper mouth"},
        {emoji: "\u{1F928}", name: "raised eyebrow"},
        {emoji: "\u{1F610}", name: "neutral"},
        {emoji: "\u{1F611}", name: "expressionless"},
        {emoji: "\u{1F636}", name: "no mouth"},
        {emoji: "\u{1F60F}", name: "smirk"},
        {emoji: "\u{1F612}", name: "unamused"},
        {emoji: "\u{1F644}", name: "rolling eyes"},
        {emoji: "\u{1F62C}", name: "grimacing"},
        {emoji: "\u{1F925}", name: "lying"},
        {emoji: "\u{1F60C}", name: "relieved"},
        {emoji: "\u{1F614}", name: "pensive"},
        {emoji: "\u{1F62A}", name: "sleepy"},
        {emoji: "\u{1F924}", name: "drooling"},
        {emoji: "\u{1F634}", name: "sleeping"},
        {emoji: "\u{1F637}", name: "medical mask"},
        {emoji: "\u{1F912}", name: "thermometer face"},
        {emoji: "\u{1F915}", name: "bandage head"},
        {emoji: "\u{1F922}", name: "nauseated"},
        {emoji: "\u{1F92E}", name: "vomiting"},
        {emoji: "\u{1F927}", name: "sneezing"},
        {emoji: "\u{1F975}", name: "hot face"},
        {emoji: "\u{1F976}", name: "cold face"},
        {emoji: "\u{1F974}", name: "woozy"},
        {emoji: "\u{1F635}", name: "dizzy face"},
        {emoji: "\u{1F92F}", name: "exploding head"},
        {emoji: "\u{1F920}", name: "cowboy"},
        {emoji: "\u{1F973}", name: "party face"},
        {emoji: "\u{1F978}", name: "disguised"},
        {emoji: "\u{1F60E}", name: "sunglasses cool"},
        {emoji: "\u{1F913}", name: "nerd"},
        {emoji: "\u{1F9D0}", name: "monocle"},
        {emoji: "\u{1F615}", name: "confused"},
        {emoji: "\u{1F61F}", name: "worried"},
        {emoji: "\u{1F641}", name: "slightly frowning"},
        {emoji: "\u{1F62E}", name: "open mouth"},
        {emoji: "\u{1F632}", name: "astonished"},
        {emoji: "\u{1F633}", name: "flushed"},
        {emoji: "\u{1F97A}", name: "pleading"},
        {emoji: "\u{1F626}", name: "frowning open mouth"},
        {emoji: "\u{1F627}", name: "anguished"},
        {emoji: "\u{1F628}", name: "fearful"},
        {emoji: "\u{1F630}", name: "anxious sweat"},
        {emoji: "\u{1F625}", name: "sad relieved"},
        {emoji: "\u{1F622}", name: "crying"},
        {emoji: "\u{1F62D}", name: "loudly crying"},
        {emoji: "\u{1F631}", name: "screaming"},
        {emoji: "\u{1F616}", name: "confounded"},
        {emoji: "\u{1F623}", name: "persevering"},
        {emoji: "\u{1F61E}", name: "disappointed"},
        {emoji: "\u{1F613}", name: "downcast sweat"},
        {emoji: "\u{1F629}", name: "weary"},
        {emoji: "\u{1F62B}", name: "tired"},
        {emoji: "\u{1F624}", name: "triumph steam"},
        {emoji: "\u{1F621}", name: "pouting angry"},
        {emoji: "\u{1F620}", name: "angry"},
        {emoji: "\u{1F92C}", name: "cursing"},
        // Gestures
        {emoji: "\u{1F44D}", name: "thumbs up"},
        {emoji: "\u{1F44E}", name: "thumbs down"},
        {emoji: "\u{1F44A}", name: "fist bump"},
        {emoji: "\u{270A}", name: "raised fist"},
        {emoji: "\u{1F91B}", name: "left fist"},
        {emoji: "\u{1F91C}", name: "right fist"},
        {emoji: "\u{1F44F}", name: "clapping"},
        {emoji: "\u{1F64C}", name: "raising hands"},
        {emoji: "\u{1F450}", name: "open hands"},
        {emoji: "\u{1F91D}", name: "handshake"},
        {emoji: "\u{1F64F}", name: "pray folded hands"},
        {emoji: "\u{270D}\u{FE0F}", name: "writing hand"},
        {emoji: "\u{1F44B}", name: "waving hand"},
        {emoji: "\u{1F91A}", name: "raised back of hand"},
        {emoji: "\u{1F590}\u{FE0F}", name: "hand splayed"},
        {emoji: "\u{270B}", name: "raised hand"},
        {emoji: "\u{1F596}", name: "vulcan salute"},
        {emoji: "\u{1F44C}", name: "ok hand"},
        {emoji: "\u{1F90C}", name: "pinched fingers"},
        {emoji: "\u{1F90F}", name: "pinching hand"},
        {emoji: "\u{270C}\u{FE0F}", name: "victory peace"},
        {emoji: "\u{1F91E}", name: "crossed fingers"},
        {emoji: "\u{1F91F}", name: "love you gesture"},
        {emoji: "\u{1F918}", name: "rock on"},
        {emoji: "\u{1F448}", name: "pointing left"},
        {emoji: "\u{1F449}", name: "pointing right"},
        {emoji: "\u{1F446}", name: "pointing up"},
        {emoji: "\u{1F447}", name: "pointing down"},
        {emoji: "\u{261D}\u{FE0F}", name: "index up"},
        {emoji: "\u{1F4AA}", name: "flexed biceps"},
        // Hearts & Symbols
        {emoji: "\u{2764}\u{FE0F}", name: "red heart"},
        {emoji: "\u{1F9E1}", name: "orange heart"},
        {emoji: "\u{1F49B}", name: "yellow heart"},
        {emoji: "\u{1F49A}", name: "green heart"},
        {emoji: "\u{1F499}", name: "blue heart"},
        {emoji: "\u{1F49C}", name: "purple heart"},
        {emoji: "\u{1F5A4}", name: "black heart"},
        {emoji: "\u{1F90D}", name: "white heart"},
        {emoji: "\u{1F494}", name: "broken heart"},
        {emoji: "\u{1F495}", name: "two hearts"},
        {emoji: "\u{1F496}", name: "sparkling heart"},
        {emoji: "\u{1F493}", name: "beating heart"},
        {emoji: "\u{1F48B}", name: "kiss mark"},
        {emoji: "\u{1F4AF}", name: "hundred points"},
        {emoji: "\u{1F4A5}", name: "collision boom"},
        {emoji: "\u{1F4AB}", name: "dizzy star"},
        {emoji: "\u{2728}", name: "sparkles"},
        {emoji: "\u{1F525}", name: "fire"},
        {emoji: "\u{1F4A9}", name: "poop"},
        {emoji: "\u{1F47B}", name: "ghost"},
        {emoji: "\u{1F480}", name: "skull"},
        {emoji: "\u{1F47D}", name: "alien"},
        {emoji: "\u{1F916}", name: "robot"},
        // Animals
        {emoji: "\u{1F436}", name: "dog face"},
        {emoji: "\u{1F431}", name: "cat face"},
        {emoji: "\u{1F42D}", name: "mouse face"},
        {emoji: "\u{1F439}", name: "hamster"},
        {emoji: "\u{1F430}", name: "rabbit"},
        {emoji: "\u{1F98A}", name: "fox"},
        {emoji: "\u{1F43B}", name: "bear"},
        {emoji: "\u{1F43C}", name: "panda"},
        {emoji: "\u{1F428}", name: "koala"},
        {emoji: "\u{1F42F}", name: "tiger face"},
        {emoji: "\u{1F981}", name: "lion"},
        {emoji: "\u{1F42E}", name: "cow face"},
        {emoji: "\u{1F437}", name: "pig face"},
        {emoji: "\u{1F438}", name: "frog"},
        {emoji: "\u{1F435}", name: "monkey face"},
        {emoji: "\u{1F427}", name: "penguin"},
        {emoji: "\u{1F426}", name: "bird"},
        {emoji: "\u{1F985}", name: "eagle"},
        {emoji: "\u{1F987}", name: "bat"},
        {emoji: "\u{1F40A}", name: "crocodile"},
        {emoji: "\u{1F422}", name: "turtle"},
        {emoji: "\u{1F40D}", name: "snake"},
        {emoji: "\u{1F419}", name: "octopus"},
        {emoji: "\u{1F41F}", name: "fish"},
        {emoji: "\u{1F42C}", name: "dolphin"},
        {emoji: "\u{1F433}", name: "whale"},
        {emoji: "\u{1F980}", name: "crab"},
        {emoji: "\u{1F98B}", name: "butterfly"},
        {emoji: "\u{1F41D}", name: "honeybee"},
        {emoji: "\u{1F41B}", name: "bug"},
        // Food & Drink
        {emoji: "\u{1F34E}", name: "red apple"},
        {emoji: "\u{1F34A}", name: "tangerine orange"},
        {emoji: "\u{1F34B}", name: "lemon"},
        {emoji: "\u{1F34C}", name: "banana"},
        {emoji: "\u{1F349}", name: "watermelon"},
        {emoji: "\u{1F347}", name: "grapes"},
        {emoji: "\u{1F353}", name: "strawberry"},
        {emoji: "\u{1F351}", name: "peach"},
        {emoji: "\u{1F352}", name: "cherries"},
        {emoji: "\u{1F355}", name: "pizza"},
        {emoji: "\u{1F354}", name: "hamburger"},
        {emoji: "\u{1F35F}", name: "french fries"},
        {emoji: "\u{1F32E}", name: "taco"},
        {emoji: "\u{1F32F}", name: "burrito"},
        {emoji: "\u{1F363}", name: "sushi"},
        {emoji: "\u{1F370}", name: "cake shortcake"},
        {emoji: "\u{1F36B}", name: "chocolate bar"},
        {emoji: "\u{1F369}", name: "donut"},
        {emoji: "\u{1F36A}", name: "cookie"},
        {emoji: "\u{2615}", name: "coffee hot beverage"},
        {emoji: "\u{1F37A}", name: "beer mug"},
        {emoji: "\u{1F377}", name: "wine glass"},
        // Travel & Weather
        {emoji: "\u{2600}\u{FE0F}", name: "sun"},
        {emoji: "\u{1F324}\u{FE0F}", name: "sun small cloud"},
        {emoji: "\u{26C5}", name: "sun behind cloud"},
        {emoji: "\u{1F325}\u{FE0F}", name: "sun behind large cloud"},
        {emoji: "\u{2601}\u{FE0F}", name: "cloud"},
        {emoji: "\u{1F327}\u{FE0F}", name: "cloud with rain"},
        {emoji: "\u{26C8}\u{FE0F}", name: "cloud lightning rain"},
        {emoji: "\u{1F329}\u{FE0F}", name: "cloud lightning"},
        {emoji: "\u{1F328}\u{FE0F}", name: "cloud snow"},
        {emoji: "\u{1F32A}\u{FE0F}", name: "tornado"},
        {emoji: "\u{1F308}", name: "rainbow"},
        {emoji: "\u{2B50}", name: "star"},
        {emoji: "\u{1F31F}", name: "glowing star"},
        {emoji: "\u{1F320}", name: "shooting star"},
        {emoji: "\u{1F30D}", name: "earth globe"},
        {emoji: "\u{1F680}", name: "rocket"},
        {emoji: "\u{2708}\u{FE0F}", name: "airplane"},
        {emoji: "\u{1F3E0}", name: "house"},
        // Objects & Symbols
        {emoji: "\u{1F4F1}", name: "mobile phone"},
        {emoji: "\u{1F4BB}", name: "laptop computer"},
        {emoji: "\u{2328}\u{FE0F}", name: "keyboard"},
        {emoji: "\u{1F4F7}", name: "camera"},
        {emoji: "\u{1F4A1}", name: "light bulb idea"},
        {emoji: "\u{1F50D}", name: "magnifying glass"},
        {emoji: "\u{1F512}", name: "locked"},
        {emoji: "\u{1F513}", name: "unlocked"},
        {emoji: "\u{1F3B5}", name: "musical note"},
        {emoji: "\u{1F3B6}", name: "musical notes"},
        {emoji: "\u{1F514}", name: "bell"},
        {emoji: "\u{1F4E7}", name: "email"},
        {emoji: "\u{1F4AC}", name: "speech bubble"},
        {emoji: "\u{1F4AD}", name: "thought bubble"},
        {emoji: "\u{2705}", name: "check mark"},
        {emoji: "\u{274C}", name: "cross mark"},
        {emoji: "\u{2757}", name: "exclamation"},
        {emoji: "\u{2753}", name: "question mark"},
        {emoji: "\u{1F6A8}", name: "police light"},
        {emoji: "\u{1F3C6}", name: "trophy"},
        {emoji: "\u{1F381}", name: "wrapped gift"},
        {emoji: "\u{1F389}", name: "party popper"},
        {emoji: "\u{1F38A}", name: "confetti ball"},
        // Flags
        {emoji: "\u{1F1FA}\u{1F1F8}", name: "flag united states"},
        {emoji: "\u{1F1EC}\u{1F1E7}", name: "flag united kingdom"},
        {emoji: "\u{1F1E9}\u{1F1EA}", name: "flag germany"},
        {emoji: "\u{1F1EB}\u{1F1F7}", name: "flag france"},
        {emoji: "\u{1F1EF}\u{1F1F5}", name: "flag japan"},
        {emoji: "\u{1F1E8}\u{1F1E6}", name: "flag canada"},
        {emoji: "\u{1F1E6}\u{1F1FA}", name: "flag australia"},
        {emoji: "\u{1F1E7}\u{1F1F7}", name: "flag brazil"},
        {emoji: "\u{1F1F3}\u{1F1F1}", name: "flag netherlands"},
        {emoji: "\u{1F3F3}\u{FE0F}\u{200D}\u{1F308}", name: "rainbow flag pride"},
        {emoji: "\u{1F3F4}\u{200D}\u{2620}\u{FE0F}", name: "pirate flag"}
    ]

    readonly property var filteredEmojis: {
        var q = filterText.toLowerCase().trim()
        if (!q) return emojiData
        return emojiData.filter(e => e.name.toLowerCase().includes(q))
    }

    Process { id: copyProc }

    function pickEmoji(emoji) {
        copyProc.command = ["wl-copy", emoji]
        copyProc.running = true
        ctrl.hide()
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
                width: 460; height: 420
                color: Theme.bg; radius: Theme.barRadius
                border.color: Theme.border; border.width: 1

                ColumnLayout {
                    anchors.fill: parent; anchors.margins: 12; spacing: 8

                    RowLayout {
                        Layout.fillWidth: true
                        Text {
                            color: Theme.fg; font.family: Theme.fontFamily
                            font.pixelSize: 16; font.bold: true
                            text: "Emoji Picker"
                        }
                        Item { Layout.fillWidth: true }
                        Text {
                            color: Theme.comment; font.family: Theme.fontFamily
                            font.pixelSize: 11
                            text: root.filteredEmojis.length + " emojis"
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true; height: 32
                        color: Theme.bgDark; radius: 4

                        TextInput {
                            id: emojiSearch
                            anchors.fill: parent; anchors.margins: 8
                            color: Theme.fg; font.family: Theme.fontFamily
                            font.pixelSize: 12; clip: true
                            onTextChanged: root.filterText = text
                            Keys.onEscapePressed: ctrl.hide()

                            Text {
                                anchors.fill: parent; color: Theme.comment
                                font: parent.font; text: "Search emojis..."
                                visible: !parent.text && !parent.activeFocus
                            }
                        }
                    }

                    GridView {
                        Layout.fillWidth: true; Layout.fillHeight: true
                        clip: true; cellWidth: 36; cellHeight: 36
                        model: root.filteredEmojis

                        delegate: Rectangle {
                            required property var modelData
                            width: 36; height: 36
                            color: emojiMouse.containsMouse ? Theme.border : "transparent"
                            radius: 4

                            Text {
                                anchors.centerIn: parent
                                font.pixelSize: 20
                                text: modelData.emoji
                            }

                            MouseArea {
                                id: emojiMouse; anchors.fill: parent
                                hoverEnabled: true
                                onClicked: root.pickEmoji(modelData.emoji)
                            }
                        }
                    }
                }
            }

            onVisibleChanged: {
                if (visible) { emojiSearch.text = ""; emojiSearch.forceActiveFocus() }
            }
            Keys.onEscapePressed: ctrl.hide()
        }
    }
}
