# Dendritic feature module: Quickshell configuration
# Provides Quickshell shell toolkit (bars, widgets, notifications, lockscreen, OSD)
# Exports: homeModules.quickshell
{ inputs, lib, ... }:
let
  inherit (inputs) self;
in
{
  flake.homeModules.quickshell =
    {
      pkgs,
      config,
      lib,
      flake,
      ...
    }:
    let
      inherit (pkgs.stdenv) isDarwin isLinux;
    in
    lib.mkIf isLinux {
      # ─────────────────────────────────────────────────────────────────────────
      # Quickshell Package
      # ─────────────────────────────────────────────────────────────────────────
      home.packages = with pkgs; [
        quickshell
        nerd-fonts.symbols-only
      ];

      # ─────────────────────────────────────────────────────────────────────────
      # Quickshell Configuration (QML)
      # ─────────────────────────────────────────────────────────────────────────
      # Deploy QML config as a single directory symlink to the live repo.
      # QML's "import qs" module resolution requires a coherent directory tree —
      # per-file symlinks from recursive=true break singleton resolution across
      # subdirectories. mkOutOfStoreSymlink with a literal path creates a mutable
      # symlink that also enables Quickshell hot-reload on file save.
      xdg.configFile."quickshell".source =
        config.lib.file.mkOutOfStoreSymlink "/home/saberzero1/Repos/croire/programs/quickshell";
    };
}
