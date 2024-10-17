{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.zsh
        pkgs.zsh-you-should-use
        pkgs.zsh-vi-mode
        pkgs.wezterm
        pkgs.just
        inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
        pkgs.ranger
      ];
    };
    programs = {
      zsh = {
        enable = true;
        enableCompletion = true;
        enableLsColors = true;
      };
      ranger = {
        enable = true;
      };
    };
    users = {
      defaultUserShell = pkgs.zsh;
    };
  };
}
