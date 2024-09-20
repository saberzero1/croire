{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    home = {
      packages = [
        pkgs.zsh
        pkgs.zsh-you-should-use
        pkgs.zsh-vi-mode
        pkgs.wezterm
      ];
    };
    programs = {
      zsh = {
        dotDir = ".config/zsh";
        enable = true;
        enableCompletion = true;
        history = {
          save = 100000;
        };
        package = pkgs.zsh;
        profileExtra = ''

        '';
        syntaxHighlighting = {
          enable = true;
        };
        shellAliases = {
          uuid = "uuidgen";
          ll = "ls -l";
          ".." = "cd ..";
        };
        enableVteIntegration = true;

        # This command let's me execute arbitrary binaries downloaded through channels such as mason.
        initExtra = ''
          export NIX_LD=$(nix eval --impure --raw --expr 'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD')
        '';
      };
      wezterm = {
        enable = true;
        package = pkgs.wezterm;
        enableZshIntegration = true;
        enableBashIntegration = true;
      };
    };
    xdg = {
      configFile = {
        "wezterm/wezterm.lua" = {
          source = /home/saberzero1/Documents/Repos/dotfiles/shelter/wezterm.lua;
        };
      };
    };
  };
}
