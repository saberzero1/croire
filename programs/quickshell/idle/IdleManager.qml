import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import qs

Scope {
    id: root

    // Tier 1: Lock after 600 minutes (36000s)
    IdleMonitor {
        id: lockMonitor
        timeout: 36000

        onIsIdleChanged: {
            if (isIdle) lockProc.running = true
        }
    }

    Process {
        id: lockProc
        command: ["loginctl", "lock-session"]
    }

    // Tier 2: DPMS off after 600.5 minutes (36030s)
    IdleMonitor {
        id: dpmsMonitor
        timeout: 36030

        onIsIdleChanged: {
            if (isIdle) {
                dpmsOffProc.running = true
            } else {
                dpmsOnProc.running = true
            }
        }
    }

    Process {
        id: dpmsOffProc
        command: ["hyprctl", "dispatch", "dpms", "off"]
    }

    Process {
        id: dpmsOnProc
        command: ["hyprctl", "dispatch", "dpms", "on"]
    }

    // Tier 3: Suspend after 1200 minutes (72000s)
    IdleMonitor {
        id: suspendMonitor
        timeout: 72000

        onIsIdleChanged: {
            if (isIdle) suspendProc.running = true
        }
    }

    Process {
        id: suspendProc
        command: ["systemctl", "suspend"]
    }
}
