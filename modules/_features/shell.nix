# Dendritic feature module: Shell configuration
# Provides unified shell configuration across all platforms (Darwin, NixOS)
# Exports: homeModules.shell (includes zsh, nushell, starship)
{ inputs, lib, ... }:
let
  inherit (inputs) self;
in
{
  flake.homeModules.shell =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      inherit (pkgs.stdenv) isDarwin isLinux;
    in
    {
      programs = {
        # ─────────────────────────────────────────────────────────────────────────
        # Zsh - Primary interactive shell
        # ─────────────────────────────────────────────────────────────────────────
        zsh = {
          enable = true;
          package = pkgs.zsh;
          dotDir = "${config.home.homeDirectory}/.config/zsh";
          autosuggestion.enable = true;
          enableCompletion = true;
          history.save = 100000;
          syntaxHighlighting.enable = true;
          enableVteIntegration = false;

          initContent = ''
            # zoxide
            eval "$(zoxide init --cmd cd zsh)"

            # starship prompt
            eval "$(starship init zsh)"

            # pay-respects (thefuck replacement)
            eval $(pay-respects zsh --alias fuck --nocnf)

            ${lib.optionalString isDarwin ''
              # Homebrew on macOS
              if [[ $(uname -m) == 'arm64' ]]; then
                eval "$(/opt/homebrew/bin/brew shellenv)"
              fi
            ''}

            ${lib.optionalString isLinux ''
              # Systemd environment on Linux
              eval $(dbus-update-activation-environment --systemd --all)
            ''}

            # Source custom shortcuts
            source "${config.home.homeDirectory}/.config/zsh/scripts/shortcuts"

            # direnv
            eval "$(direnv hook zsh)"

            # tmux sessionizer keybinding
            bindkey -s "^F" "tmux-sessionizer\n"
          '';

          plugins = [
            {
              name = "zsh-autopair";
              src = pkgs.zsh-autopair;
              file = "share/zsh-autopair/zsh-autopair.zsh";
            }
            {
              name = "zsh-autosuggestions";
              src = pkgs.zsh-autosuggestions;
              file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
            }
            {
              name = "vi-mode";
              src = pkgs.zsh-vi-mode;
              file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
            }
            {
              name = "zsh-you-should-use";
              src = pkgs.zsh-you-should-use;
              file = "share/zsh-you-should-use/zsh-vi-mode.plugin.zsh";
            }
          ];
        };

        # ─────────────────────────────────────────────────────────────────────────
        # Nushell - Modern shell with structured data
        # ─────────────────────────────────────────────────────────────────────────
        nushell = {
          enable = true;

          settings = {
            show_banner = false;
            history = {
              max_size = 100000;
              sync_on_enter = true;
              file_format = "sqlite";
              isolation = false;
            };
            completions = {
              case_sensitive = false;
              quick = true;
              partial = true;
              algorithm = "fuzzy";
              sort = "smart";
              external = {
                enable = true;
                max_results = 100;
              };
            };
            buffer_editor = "nvim";
            edit_mode = "vi";
            cursor_shape = {
              emacs = "line";
              vi_insert = "line";
              vi_normal = "block";
            };
            recursion_limit = 50;
          };

          extraConfig = ''
            # Custom PATH additions
            $env.PATH = ($env.PATH | split row (char esep) | prepend ($env.HOME | path join ".local/bin"))

            # Keybindings
            $env.config.keybindings = ($env.config.keybindings | append {
              name: tmux_sessionizer
              modifier: control
              keycode: char_f
              mode: [emacs vi_normal vi_insert]
              event: { send: executehostcommand cmd: "tmux-sessionizer" }
            })

            # Carapace completions
            source "~/.config/nushell/integration/carapace.nu"

            # Zoxide
            source "~/.config/nushell/integration/zoxide.nu"
          '';

          extraEnv = ''
            # Editor
            $env.EDITOR = "nvim"
            $env.VISUAL = "nvim"

            # XDG directories
            $env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")
            $env.XDG_DATA_HOME = ($env.HOME | path join ".local/share")
            $env.XDG_CACHE_HOME = ($env.HOME | path join ".cache")

            # NU_LIB_DIRS for custom modules
            $env.NU_LIB_DIRS = [
              ($env.HOME | path join ".config/nushell/scripts")
              ($env.HOME | path join ".local/share/nushell")
            ]

            # NU_PLUGIN_DIRS for plugins
            $env.NU_PLUGIN_DIRS = [
              ($env.HOME | path join ".config/nushell/plugins")
            ]

            # VI indicators
            $env.PROMPT_INDICATOR_VI_NORMAL = ""
            $env.PROMPT_INDICATOR_VI_INSERT = ""

            # Carapace bridges
            $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
          '';

          extraLogin = "";

          shellAliases = { };

          environmentVariables = {
            SHELL = "${pkgs.nushell}/bin/nu";
          };
        };

        # ─────────────────────────────────────────────────────────────────────────
        # Starship - Cross-shell prompt
        # ─────────────────────────────────────────────────────────────────────────
        starship = {
          enable = true;
          settings = pkgs.lib.importTOML "${self}/programs/starship/starship.toml";
          enableZshIntegration = true;
          enableBashIntegration = true;
          enableNushellIntegration = true;
        };

        # ─────────────────────────────────────────────────────────────────────────
        # Shell utilities
        # ─────────────────────────────────────────────────────────────────────────
        zoxide = {
          enable = true;
          enableZshIntegration = true;
          enableNushellIntegration = true;
        };

        direnv = {
          enable = true;
          enableZshIntegration = true;
          enableNushellIntegration = true;
          nix-direnv.enable = true;
        };

        fzf = {
          enable = true;
          enableZshIntegration = true;
        };

        carapace = {
          enable = true;
          enableZshIntegration = true;
          enableNushellIntegration = true;
        };
      };

      # Nushell integration files
      home.file = {
        "carapace.nu" = {
          target = ".config/nushell/integration/carapace.nu";
          text = "carapace _carapace";
        };
        "zoxide.nu" = {
          target = ".config/nushell/integration/zoxide.nu";
          text = "zoxide init nushell";
        };
      };
    };
}
