{ flake, pkgs, ... }:
{
  # Programs natively supported by home-manager.
  # They can be configured in `programs.*` instead of using home.packages.
  programs = {
    # Better `cat`
    bat.enable = true;
    # Type `<ctrl> + r` to fuzzy search your shell history
    fzf.enable = true;
    jq = {
      colors = {
        arrays = "1;37";
        false = "0;37";
        null = "1;30";
        numbers = "0;37";
        objects = "1;37";
        strings = "0;32";
        true = "0;37";
      };
      enable = true;
      package = pkgs.jq;
    };
    # Install btop https://github.com/aristocratos/btop
    btop.enable = true;

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    neovim = {
      defaultEditor = true;
      enable = true;
      package = pkgs.neovim;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
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

    wezterm = {
      enable = true;
      package = pkgs.wezterm;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };

    ghostty = {
      enable = true;
      package = pkgs.ghostty;
      shellIntegration = {
        enable = true;
        enableZshIntegration = true;
      };
      settings = {
        font-size = 16;
        font-family = "Monaspace Neon";

        # MacOS settings
        window-theme = "dark";
        macos-option-as-alt = true;

        # Config file
        config-file = [
          "${flake.inputs.color-schemes}/Ghostty/Tomorrow Night Bright"
        ];

        # Keybindings
        clearDefaultKeybindings = false;
        # keybindings = {};
      };
    };

    starship = {
      enable = true;
      settings = pkgs.lib.importTOML "${flake.inputs.dotfiles}/starship/starship.toml";
      enableZshIntegration = true;
      enableBashIntegration = true;
    };

    ranger = {
      enable = true;
      package = pkgs.ranger;
    };

    tmux = {
      enable = true;
    };

    thefuck = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableInstantMode = false;
    };

    zoxide = {
      enable = true;
      package = pkgs.zoxide;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };

    zsh = {
      enable = true;
      dotDir = ".config/zsh";
      autosuggestion = {
        enable = true;
      };
      enableCompletion = true;
      history = {
        save = 100000;
      };
      syntaxHighlighting = {
        enable = true;
      };
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

    ripgrep = {
      enable = true;
      package = pkgs.ripgrep;
    };

    vscode = {
      enable = false;
      enableExtensionUpdateCheck = true;
      mutableExtensionsDir = true;
      package = pkgs.vscodium.fhs;
    };
  };
}
