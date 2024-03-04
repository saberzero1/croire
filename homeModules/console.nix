{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    home = {
      packages = [
        pkgs.oh-my-zsh
        pkgs.zsh
        pkgs.zsh-you-should-use
        pkgs.zsh-vi-mode
        pkgs.oh-my-posh
      ];
    };
    programs = {
      oh-my-posh = {
        enable = true;
        enableZshIntegration = true;
        package = pkgs.oh-my-posh;
        settings = ;
          useTheme = "tokyonight_storm";
      };
      zsh = {
        dotDir = ".config/zsh";
        enable = true;
        enableCompletion = true;
        history = {
          save = 100000;
        };
        oh-my-zsh = { };
        package = pkgs.zsh;
        plugins = ;
          profileExtra = "";
        syntaxHighlighting = ;
          };
      };
    };
  }
