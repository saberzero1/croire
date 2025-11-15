{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  environment = {
    systemPackages = with pkgs; [
      diff-so-fancy
      gh
      lazygit
      gitFull
      tree-sitter
      sqlfluff
      viu
      chafa
      # ueberzugpp
      haskellPackages.hoogle
      fh

      xcodes
      apple-sdk
      pre-commit

      bun

      # opencode

      # Sketchybar
      lua54Packages.lua
      sketchybar-app-font
      sbarlua

      ispell
      kvazaar
      fish
    ];
  };
}
