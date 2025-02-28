{ pkgs, config, ... }:
{
  # Programs natively supported by home-manager.
  # They can be configured in `programs.*` instead of using home.packages.
  programs = {
    zsh = {
      enable = true;
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

        # Aerospace on Silicon
        if [[ $(uname -m) == 'arm64' ]]; then
          eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
      '';
    };

    # Configure key name per device.
    #
    # Use gpg2.
    #
    # gpg2 --full-generate-key
    # gpg2 --list-secret-keys --keyid-format=long
    # gpg2 --armor --export 1234567890ABCDEF
    git = {
      diff-so-fancy = {
        changeHunkIndicators = true;
        enable = true;
        markEmptyLines = true;
        pagerOpts = [
          "--tabs=4"
          "-RFX"
        ];
        rulerWidth = null;
        stripLeadingSymbols = true;
        useUnicodeRuler = true;
      };
      enable = true;
      package = pkgs.git;
      # package = pkgs.gitFull;
      userName = "saberzero1";
      userEmail = "github@emilebangma.com";
      ignores = [
        "*.swp"
      ];
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
        gpg.format = "ssh";
        user.signingkey = "${config.home.homeDirectory}/.ssh/saberzero1-github.pub";
        pull.rebase = true;
        rebase.autoStash = true;
      };
    };
  };
}
