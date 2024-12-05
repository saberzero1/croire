{ config, pkgs, lib, ... }:

let
  gitName = "saberzero1";
  gitEmail = "github@emilebangma.com";
in
{
  direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
  zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
    };
    enableCompletion = true;
    history = {
      save = 100000;
    };
    enableSyntaxHighlighting = {
      enable = true;
    };
    autocd = false;
    promptInit = ''
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

      # Environment variables
      export EDITOR = "nvim"
      export VISUAL = "nvim"
      export TERM = "wezterm"
    '';
  };
  git = {
    enable = true;
    ignores = [
      "*.swp"
    ];
    userName = gitName;
    userEmail = gitEmail;
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
    package = pkgs.neovim-unwrapped;
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
  starship = {
    enable = true;
    settings = pkgs.lib.importTOML "${config.home.homeDirectory}/.config/starship.toml";
    enableZshIntegration = true;
    enableBashIntegration = true;
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
}
