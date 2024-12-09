{ flake, pkgs, ... }:
{
  # Programs natively supported by home-manager.
  # They can be configured in `programs.*` instead of using home.packages.
  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
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
      autocd = false;
      #defaultKeymap = "vicmd";
      initExtra = ''
        # zoxide
        eval "$(zoxide init --cmd cd zsh)"

        # atuin
        # eval "$(atuin init zsh --disable-up-arrow)"

        # direnv
        eval "$(direnv hook zsh)"

        # starship
        eval "$(starship init zsh)"

        # thefuck
        eval $(thefuck --alias fuck)
      '';
      profileExtra = ''
        # Aerospace on Silicon
        eval "$(/opt/homebrew/bin/brew shellenv)"
      '';
    };
    git = {
      enable = true;
      ignores = [
        "*.swp"
      ];
      userName = "saberzero1";
      userEmail = "github@emilebangma.com";
      lfs = {
        enable = true;
      };
      extraConfig = {
        init.defaultBranch = "master";
        core = {
          editor = "nvim";
          autocrlf = "input";
        };
        commit.gpgsign = true;
        pull.rebase = true;
        rebase.autoStash = true;
      };
    };
    neovim = {
      defaultEditor = true;
      enable = true;
      package = pkgs.neovim;
      #package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
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
      #package = inputs.wezterm.packages.${pkgs.system}.default;
      enableZshIntegration = true;
      enableBashIntegration = true;
      #extraConfig = ''
      #  local init = require "init"
      #
      #  return init
      #'';
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
  };
}
