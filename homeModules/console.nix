{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    home = {
      packages = [
        pkgs.oh-my-zsh
        pkgs.zsh
        pkgs.zsh-you-should-use
        pkgs.zsh-vi-mode
      ];
    };
    programs = {
      zsh = {
        enable = true;
        oh-my-zsh = { };
        package = pkgs.zsh;
        syntaxHighlighting = {
          enable = true;
          package = pkgs.zsh-syntax-highlighting;
        };
        zplug = {
          enable = true;
        };
      };
    };
  };
}
