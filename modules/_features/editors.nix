# Dendritic feature module: Editor configuration
# Provides unified editor configuration across all platforms
# Exports: homeModules.editors (nvf, lazyvim, helix, emacs)
{ inputs, lib, ... }:
let
  inherit (inputs) self;
in
{
  flake.homeModules.editors =
    {
      flake,
      pkgs,
      config,
      lib,
      ...
    }:
    let
      inherit (flake) inputs;
    in
    {
      imports = [
        # NVF (Neovim via nvf)
        inputs.nvf.homeManagerModules.default
        (self + /lib/modules/home/shared/programs/nvf)

        # LazyVim (disabled by default)
        inputs.lazyvim.homeManagerModules.default
        (self + /lib/modules/home/shared/programs/lazyvim)
      ];

      programs = {
        # ─────────────────────────────────────────────────────────────────────────
        # NVF - Neovim configuration framework
        # ─────────────────────────────────────────────────────────────────────────
        nvf = {
          enable = true;
          defaultEditor = true;
          settings = {
            vim = {
              viAlias = true;
              vimAlias = true;
              withNodeJs = true;
              withPython3 = true;
              python3Packages = [ "pynvim" ];
              withRuby = true;
              preventJunkFiles = true;
              searchCase = "smart";
              syntaxHighlighting = true;
              undoFile.enable = true;
            };
          };
        };

        # ─────────────────────────────────────────────────────────────────────────
        # LazyVim - Alternative Neovim configuration (disabled)
        # ─────────────────────────────────────────────────────────────────────────
        lazyvim = {
          enable = false;
          pluginSource = "latest";
          extraPackages = with pkgs; [
            curl
            fd
            fzf
            git
            lazygit
            ripgrep
          ];
        };

        # ─────────────────────────────────────────────────────────────────────────
        # Helix - Modal editor with built-in LSP
        # ─────────────────────────────────────────────────────────────────────────
        helix = {
          enable = true;
          package = pkgs.evil-helix;
          settings = {
            theme = "tokyonight";
            editor = {
              auto-format = true;
              color-modes = true;
              evil = true;
              insert-final-newline = true;
              line-number = "relative";
              cursor-shape = {
                insert = "bar";
                normal = "block";
                select = "underline";
              };
              inline-diagnostics = {
                cursor-line = "hint";
              };
              lsp = {
                enable = true;
                display-messages = true;
              };
            };
            keys = {
              normal = {
                space = {
                  space = "file_picker";
                  s.g = "global_search";
                };
                "{" = "goto_prev_paragraph";
                "}" = "goto_next_paragraph";
                C-j = [
                  "extend_to_line_bounds"
                  "delete_selection"
                  "paste_after"
                ];
                C-k = [
                  "extend_to_line_bounds"
                  "delete_selection"
                  "move_line_up"
                  "paste_before"
                ];
              };
            };
          };
        };

        # ─────────────────────────────────────────────────────────────────────────
        # Emacs (disabled by default)
        # ─────────────────────────────────────────────────────────────────────────
        emacs = {
          enable = false;
        };

        # ─────────────────────────────────────────────────────────────────────────
        # VSCode/VSCodium (disabled by default)
        # ─────────────────────────────────────────────────────────────────────────
        vscode = {
          enable = false;
          profiles = {
            default = {
              enableExtensionUpdateCheck = true;
            };
          };
          mutableExtensionsDir = true;
          package = pkgs.vscodium.fhs;
        };
      };

      # ─────────────────────────────────────────────────────────────────────────
      # Editor configuration files
      # ─────────────────────────────────────────────────────────────────────────
      home.file = {
        doom = {
          target = ".config/doom";
          source = "${self}/programs/doom";
          recursive = true;
        };
        emacs = {
          target = ".config/emacs";
          source = "${self}/programs/emacs";
          recursive = true;
        };
      };
    };
}
