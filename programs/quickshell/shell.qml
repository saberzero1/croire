import Quickshell
import QtQuick
import "bar"
import "launcher"
import "notifications"
import "osd"
import "idle"
import "lockscreen"
import "wallpaper"
import "components"

ShellRoot {
    // ── Core replacements (Phases 1-7) ──────────────────────────────────
    Bar {}                   // Status bar (replaces Waybar)
    Launcher {}              // App launcher (replaces Wofi/Fuzzel) — qs ipc call launcher toggle
    NotificationDaemon {}    // Notifications (replaces Mako)
    VolumeOsd {}             // Volume OSD (replaces Avizo)
    BrightnessOsd {}         // Brightness OSD (replaces Avizo)
    IdleManager {}           // Idle management (replaces Hypridle)
    LockScreen {}            // Lock screen (replaces Hyprlock)
    Wallpaper {}             // Wallpaper (replaces Hyprpaper)

    // ── Enhancements (Phase 8) — new capabilities ──────────────────────
    PowerMenu {}             // Power menu popup — qs ipc call power toggle
    MediaWidget {}           // MPRIS media controls — qs ipc call media toggle
    Overview {}              // Live window preview — qs ipc call overview toggle
    AudioMixer {}            // Per-app volume mixer — qs ipc call mixer toggle
    NetworkPanel {}          // WiFi manager — qs ipc call network toggle
    BluetoothPanel {}        // Bluetooth manager — qs ipc call bluetooth toggle
    PolkitAgent {}           // Polkit auth dialog — qs ipc call polkit authenticate "message"
    ScreenshotOverlay {}     // Screenshot region selector — qs ipc call screenshot area

    // ── Enhancements (Phase 9) — utilities ──────────────────────────────
    ClipboardHistory {}      // Clipboard history — qs ipc call clipboard toggle
    EmojiPicker {}           // Emoji picker — qs ipc call emoji toggle
    Reminders {}             // Reminders — qs ipc call reminders show
    NightlightService {}     // Nightlight auto — qs ipc call nightlight toggle
    WeatherPanel {}          // Weather — qs ipc call weather toggle
    SpeedTest {}             // Speed test — qs ipc call speedtest run
}
