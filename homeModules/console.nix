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
        pkgs.wezterm
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
        dotDir = ".config/zsh";
        enable = true;
        autosuggestions = {
          enable = true;
        };
        enableCompletion = true;
        history = {
          save = 100000;
        };
        ohMyZsh = {
          enable = true;
          package = pkgs.oh-my-zsh;
          theme = "tokyonight_storm";
          plugins = [

          ];
        };
        package = pkgs.zsh;
        plugins = [
          "git"
          "sudo"
        ];
        profileExtra = ''
          '''

          '''
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
      };
    };
  };
}
