{ pkgs, ... }:
{
  home.packages = with pkgs; [
    deadnix
    nixd
    nixpkgs-fmt
    nixfmt
    statix
  ];
}
