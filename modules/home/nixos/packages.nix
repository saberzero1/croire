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
  ];
}
