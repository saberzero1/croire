{ pkgs, ... }:
{
  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages = with pkgs; [
    # Mac
    fswatch
    # dockutil # Moved to homebrew formula - Swift build broken in nixpkgs (issue #462451)
    # aerospace

    # sketchybar
    # lua54Packages.lua
    # sketchybar-app-font
    # sbarlua
  ];
}
