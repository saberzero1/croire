# Darwin Homebrew Package Management
# Consolidated casks, formulae, masApps, and taps configuration
{ flake, ... }:
let
  flakeTaps = {
    "homebrew/homebrew-bundle" = flake.inputs.homebrew-bundle;
    "homebrew/homebrew-core" = flake.inputs.homebrew-core;
    "homebrew/homebrew-cask" = flake.inputs.homebrew-cask;
    "FelizKratz/homebrew-formulae" = flake.inputs.homebrew-felixkratz-tap;
    "nikitabobko/homebrew-tap" = flake.inputs.homebrew-nikitabobko-tap;
  };
in
{
  nix-homebrew = {
    enable = true;
    user = "emile";
    taps = flakeTaps;
    autoMigrate = true;
  };

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "none";
    };

    global = {
      autoUpdate = true;
    };

    taps = builtins.attrNames flakeTaps;

    # =========================================
    # Homebrew Casks (GUI Applications)
    # =========================================
    casks = [
      "aerospace"
      "calibre"
      "docker-desktop"
      "dotnet-sdk"
      "espanso"
      "firefox"
      "font-sf-mono"
      "font-sf-pro"
      "font-sketchybar-app-font"
      "ghostty"
      "gitbutler"
      "homebrew/cask/gimp"
      "iterm2"
      "keymapp"
      "macfuse"
      "nordlayer"
      "obsidian"
      "sf-symbols"
      "sol"
      "utm"
      "wavebox"
      "wezterm"
      "windows-app"
      "zen"
    ];

    # =========================================
    # Homebrew Formulae (CLI Tools)
    # =========================================
    brews = [
      "coreutils"
      "docker"
      "nowplaying-cli"
      "pre-commit"
      "switchaudio-osx"
      "tree-sitter-cli"
    ];

    # =========================================
    # Mac App Store Apps
    # =========================================
    masApps = { };
  };
}
