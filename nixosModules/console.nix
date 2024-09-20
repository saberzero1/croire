{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.zsh
        pkgs.zsh-you-should-use
        pkgs.zsh-vi-mode
        pkgs.wezterm
      ];
    };
    programs = {
      zsh = {
        enable = true;
        enableCompletion = true;
        enableLsColors = true;
      };
      wezterm = {
        enable = true;
        package = pkgs.wezterm;
        enableZshIntegration = true;
        enableBashIntegration = true;
      };
    };
    users = {
      defaultUserShell = pkgs.zsh;
      #defaultUserShell = pkgs.wezterm;
    };
  };
}
