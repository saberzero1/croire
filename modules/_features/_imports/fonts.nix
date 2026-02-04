# Shared font configuration for Darwin and NixOS
# Import this module in darwin-system.nix and nixos-system.nix
{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    # Fira Code
    fira-code
    fira-code-symbols
    nerd-fonts.fira-code
    nerd-fonts.fira-mono

    # Monaspace
    monaspace
    nerd-fonts.monaspace

    # Other Nerd Fonts
    nerd-fonts.droid-sans-mono
    nerd-fonts.mononoki
  ];
}
