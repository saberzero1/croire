{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  imports = [
    inputs.self.homeModules.neovim_language_dependencies
  ];
  config = {
    home = {
      packages = [
        pkgs.python311Packages.pynvim
        pkgs.neovim-unwrapped
        pkgs.neovide
        pkgs.git
        pkgs.gnumake
        pkgs.unzip
        pkgs.gcc
        pkgs.ripgrep
        pkgs.fd
        pkgs.jq
      ];
    };
    programs = {
      neovim = {
        defaultEditor = true;
        enable = true;
        package = pkgs.neovim-unwrapped;
        viAlias = true;
        vimAlias = true;
        withNodeJs = true;
        withPython3 = true;
        withRuby = true;
      };
    };
    xdg = {
      configFile = {
        nvim = {
          enable = true;
          recursive = true;
          source = /home/saberzero1/Documents/Repos/dotfiles/shelter;
        };
      };
    };
  };
}
