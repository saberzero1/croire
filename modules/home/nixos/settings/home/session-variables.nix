{ flake, pkgs, ... }:
{
  home.sessionVariables = {
    TERM = "xterm-ghostty";
    DEFAULT_BROWSER = "${flake.inputs.zen-browser}/bin/zen";
    BROWSER = "${flake.inputs.zen-browser}/bin/zen";
    DL_VIDEODRIVER = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    _JAVA_AWT_WM_NONREPARENTING = 1;
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM_PLUGIN_PATH = "${pkgs.libsForQt5.qt5.qtbase.bin}/lib/qt-${pkgs.libsForQt5.qt5.qtbase.version}/plugins";
    NIXOS_OZONE_WL = "1";
    LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:${pkgs.glib.out}/lib";
    TS_EXTRA_SEARCH_PATHS = ""; # e.g. "(~/ ~/Repos)";
  };
}
