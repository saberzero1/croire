{ pkgs, ... }:
{
  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages = with pkgs; [
    wavebox
    firefox
    ulauncher
    freerdp
    wl-clipboard

    # Extras
    hdparm
    hplip
    htop
    imagemagick
    mpv
    pamixer
    pciutils
    usbutils

    atuin
    gh-dash
    xclicker

    pika-backup

    # Python
    python313Full
    python312Packages.pynvim

    # Lua
    luajit

    # VSCopium
    vscode-extensions.asvetliakov.vscode-neovim
    vscodium.fhs
  ];
}
