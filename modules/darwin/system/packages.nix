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
      go

      # opencode

      # Sketchybar
      lua54Packages.lua
      sketchybar-app-font
      sbarlua

      ispell

      # kubernetes
      k9s
      kubernetes-helm
      kubernetes-polaris # linting tool for kubernetes
      kubectl
      # kty
      kind # local kubernetes clusters
      kail # log viewer for kubernetes
      helmsman
      helmfile
      helm-docs
    ];
  };
}
