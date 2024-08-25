{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.oh-my-zsh
        pkgs.zsh
        pkgs.zsh-you-should-use
        pkgs.zsh-vi-mode
        pkgs.oh-my-posh
        pkgs.neovide
      ];
    };
    programs = {
      oh-my-posh = {
        enable = true;
        enableZshIntegration = true;
        package = pkgs.oh-my-posh;
        settings = { };
        useTheme = "tokyonight_storm";
      };
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
