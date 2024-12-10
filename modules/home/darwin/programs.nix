{ flake, config, pkgs, ... }:
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
      '';
      profileExtra = ''
        # Aerospace on Silicon
        eval "$(/opt/homebrew/bin/brew shellenv)"
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
      signing = {
        key =
          if config.networking.hostName == "nixos" then "41AEE99107640F10"
          else if config.networking.hostName == "croire" then null
          else if config.networking.hostName == "croire-low" then "198769D1B0D0DF8C"
          else null;
        signByDefault = true;
      };
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
        pull.rebase = true;
        rebase.autoStash = true;
      };
    };
  };
}
