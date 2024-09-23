{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: let
  neovim_config = /home/saberzero1/Documents/Repos/dotfiles/shelter;
  #neovim_config = ../../shelter;
in {
  imports = [
    inputs.self.homeModules.neovim_language_dependencies
  ];
  config = {
    home = {
      packages = [
        pkgs.python312Packages.pynvim
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
        plugins = with pkgs.vimPlugins; [
          luasnip
          #bad-practices.nvim
          cmp-nvim-lsp
          cmp-path
          cmp_luasnip
          #code-stats-vim
          conform-nvim
          copilot-cmp
          #copilot-lualine
          copilot-lua
          dashboard-nvim
          diffview-nvim
          fidget-nvim
          gitsigns-nvim
          harpoon2
          #harpoon-lualine
          lazy-nvim
          lazydev-nvim
          lualine-nvim
          luvit-meta
          mason-lspconfig-nvim
          mason-tool-installer-nvim
          mason-nvim
          neocord
          mini-nvim
          nvim-cmp
          nvim-colorizer-lua
          nvim-lspconfig
          nvim-notify
          #nvim-repl
          nvim-scrollbar
          nvim-spectre
          nvim-treesitter
          nvim-treesitter.withAllGrammars
          nvim-web-devicons
          plenary-nvim
          statuscol-nvim
          telescope-fzf-native-nvim
          telescope-ui-select-nvim
          telescope-nvim
          todo-comments-nvim
          tokyonight-nvim
          vim-be-good
          vim-fugitive
          vim-sleuth
          which-key-nvim
        ];
        /*extraLuaConfig = ''
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
        extraPackages = with pkgs; [
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
