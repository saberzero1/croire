pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root

  // ─────────────────────────────────────────────────────────────────────────
  // Tokyo Night Storm — Color Palette
  // ─────────────────────────────────────────────────────────────────────────
  readonly property color bg: "#24283b"
  readonly property color bgDark: "#1a1b26"
  readonly property color fg: "#c0caf5"
  readonly property color comment: "#565f89"
  readonly property color border: "#414868"

  readonly property color blue: "#7aa2f7"
  readonly property color cyan: "#7dcfff"
  readonly property color cyanAlt: "#2ac3de"
  readonly property color purple: "#bb9af7"
  readonly property color red: "#f7768e"
  readonly property color yellow: "#e0af68"
  readonly property color green: "#9ece6a"

  readonly property color powerBg: "#db4b4b"

  // ─────────────────────────────────────────────────────────────────────────
  // Typography
  // ─────────────────────────────────────────────────────────────────────────
  readonly property string fontFamily: "Mononoki Nerd Font"
  readonly property string fontFamilyDisplay: "Monaspace Neon"
  readonly property int fontSize: 14

  // ─────────────────────────────────────────────────────────────────────────
  // Layout (mutable — overridden by config.json at runtime)
  // ─────────────────────────────────────────────────────────────────────────
  property int barHeight: 38
  property int barMargin: 5
  property int barMarginOuter: 10
  property int barRadius: 5
  property int barPadding: 10
  property int barSpacing: 10

  // ─────────────────────────────────────────────────────────────────────────
  // Live config — FileView watches config.json for runtime changes
  // ─────────────────────────────────────────────────────────────────────────
  FileView {
      id: configFile
      path: Qt.resolvedUrl("config.json")
      watchChanges: true
      onLoaded: root.applyConfig(text())
      onFileChanged: reload()
  }

  function applyConfig(raw) {
      try {
          var cfg = JSON.parse(raw)
          if (cfg.bar) {
              if (cfg.bar.height !== undefined) root.barHeight = cfg.bar.height
              if (cfg.bar.margin !== undefined) root.barMargin = cfg.bar.margin
              if (cfg.bar.marginOuter !== undefined) root.barMarginOuter = cfg.bar.marginOuter
              if (cfg.bar.radius !== undefined) root.barRadius = cfg.bar.radius
              if (cfg.bar.padding !== undefined) root.barPadding = cfg.bar.padding
              if (cfg.bar.spacing !== undefined) root.barSpacing = cfg.bar.spacing
          }
      } catch (e) {
          console.warn("config.json parse error:", e)
      }
  }
}
