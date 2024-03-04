{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    home = {
      packages = [
        # pkgs.nixvim
        pkgs.nixvim.homeManagerModules.nixvim
        # For home-manager
        # nixvim.homeManagerModules.nixvim
        # For NixOS
        # nixvim.nixosModules.nixvim
        # For nix-darwin
        # nixvim.nixDarwinModules.nixvim
      ];
    };
    programs = {
      nixvim = {
        enable = true;
        # clipboard = {
        #   register = "unnamedplus";
        #   providers = {};
        # };
        options = {
          number = true; # Show line numbers
          relativenumber = true; # Show relative line numbers
          shiftwidth = 4; # Tab width should be 4
          mouse = "a";
          showmode = false;
          clipboard = "unnamedplus";
          breakindent = true;
          undofile = true;
          ignorecase = true;
          smartcase = true;
          signcolumn = "yes";
          updatetime = 250;
          timeoutlen = 300;
          splitright = true;
          splitbelow = true;
          list = true;
          listchars = {
            tab = "» ";
            trail = "·";
            nbsp = "␣";
          };
          inccommand = "split";
          cursorline = true;
          scrolloff = 10;
          hlsearch = true;
        };
        colorschemes = {
          tokyonight = {
            enable = true;
            style = "storm";
            styles = {
              comments = {
                italic = true;
              };
              floats = "dark";
              functions = { };
              keywords = {
                italic = true;
              };
              sidebars = "dark";
              variables = { };
            };
          };
        };
        plugins = {
          lightline = {
            enable = true;
          };
        };
        extraPlugins = with pkgs.vimPlugins; [
          vim-nix
        ];
        globals = {
          mapleader = " ";
          maplocalleader = " ";
        };
        # https://github.com/nix-community/nixvim?tab=readme-ov-file#key-mappings
        keymaps = [
          {
            mode = "n";
            key = ";";
            action = ":";
          }
          {
            mode = "n";
            key = "<Esc>";
            action = "<cmd>nohlsearch<CR>";
          }
          {
            mode = "n";
            key = "[d";
            action = vim.diagnostic.goto_prev;
            desc = "Go to previous [D]iagnostic message";
          }
          {
            mode = "n";
            key = "]d";
            action = vim.diagnostic.goto_next;
            desc = "Go to next [D]iagnostic message";
          }
          {
            mode = "n";
            key = "<leader>e";
            action = vim.diagnostic.open_float;
            desc = "Show diagnostic [E]rror messages";
          }
          {
            mode = "n";
            key = "<leader>q";
            action = vim.diagnostic.setloclist;
            desc = "Open diagnostic [Q]uickfix list";
          }
          {
            mode = "t";
            key = "<Esc><Esc>";
            action = "<C-\\><C-n>";
            desc = "Exit terminal mode";
          }
          {
            mode = "n";
            key = "<C-h>";
            action = "<C-w><C-h>";
            desc = "Move focus to the left window";
          }
          {
            mode = "n";
            key = "<C-l>";
            action = "<C-w><C-l>";
            desc = "Move focus to the right window";
          }
          {
            mode = "n";
            key = "<C-j>";
            action = "<C-w><C-j>";
            desc = "Move focus to the lower window";
          }
          {
            mode = "n";
            key = "<C-k>";
            action = "<C-w><C-k>";
            desc = "Move focus to the upper window";
          }
        ];
        autoGroups = {
          kickstart-highlight-yank = {
            clear = true;
          }
            };
          autoCmd = [
            {
              event = "TextYankPost";
              desc = "Highlight when yanking (copying) text";
              group = "kickstart-highlight-yank";
              callback = {
                __raw = "function() vim.highlight.on_yank() end";
              };
            }
          ];
          extraConfigLua = ''
            -- Print a little welcome message when nvim is opened!
            print("Hello world!")
          '';
        };
      };
    };
  }
