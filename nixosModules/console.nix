{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.zsh
        pkgs.zsh-you-should-use
        pkgs.zsh-vi-mode
        pkgs.wezterm
        pkgs.nautilus-open-any-terminal
        pkgs.just
        inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
      ];
    };
    programs = {
      zsh = {
        enable = true;
        enableCompletion = true;
        enableLsColors = true;
      };
      nautilus-open-any-terminal = {
        enable = true;
        terminal = "wezterm";
      };
    };
    users = {
      defaultUserShell = pkgs.zsh;
      #defaultUserShell = pkgs.wezterm;
    };
  };
}
