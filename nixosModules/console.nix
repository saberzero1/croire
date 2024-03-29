{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.oh-my-zsh
        pkgs.zsh
        pkgs.zsh-you-should-use
        pkgs.zsh-vi-mode
      ];
    };
    programs = {
      zsh = {
        enable = true;
        enableCompletion = true;
        enableLsColors = true;
        ohMyZsh = {
          enable = true;
        };
      };
    };
    users = {
      defaultUserShell = pkgs.zsh;
    };
  };
}
