{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: let
  #neovim_config = /home/saberzero1/Documents/Repos/dotfiles/shelter;
  neovim_config = ../../shelter;
in {
  imports = [
    inputs.self.homeModules.neovim_language_dependencies
  ];
  config = {
    home = {
      packages = [
        pkgs.python311Packages.pynvim
        pkgs.neovim-unwrapped
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
        vimdiffAlias = true;
        withNodeJs = true;
        withPython3 = true;
        withRuby = true;
        /*plugins = with pkgs.vimPlugins; [
          lazy-nvim
        ];
        extraLuaConfig = ''
          vim.g.mapleader = " " -- Need to set leader before lazy for correct keybindings
          require("lazy").setup({
            performance = {
              reset_packpath = false,
              rtp = {
                  reset = false,
                }
              },
            dev = {
              path = "/home/saberzero1/Documents/nvim-data",
            },
            install = {
              -- Safeguard in case we forget to install a plugin with Nix
              missing = false,
            },
          })
        '';*/
        extraPackages = [
          alejandra
          black
          golangci-lint
          gopls
          gotools
          hadolint
          isort
          lua-language-server
          markdownlint-cli
          nixd
          nodePackages.bash-language-server
          nodePackages.prettier
          pyright
          ruff
          shellcheck
          shfmt
          stylua
          terraform-ls
          tflint
          vscode-langservers-extracted
          yaml-language-server
        ];
      };
    };
    xdg = {
      configFile = {
        nvim = {
          enable = true;
          recursive = true;
          source = "${neovim_config}";
        };
      };
    };
  };
}
