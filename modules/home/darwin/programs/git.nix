{ pkgs, config, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  # Configure key name per device.
  #
  # Use gpg2.
  #
  # gpg2 --full-generate-key
  # gpg2 --list-secret-keys --keyid-format=long
  # gpg2 --armor --export 1234567890ABCDEF

  programs = {
    git = {
      enable = true;
      package = pkgs.gitFull;
      includes =
        if isDarwin then
          [
            {
              path = "${config.home.homeDirectory}/work_gitconfig";
              condition = "gitdir:${config.home.homeDirectory}/Work/External/Repos/";
            }
          ]
        else
          [ ];
      ignores = [
        "*.swp"
      ];
      lfs = {
        enable = true;
      };
      settings = {
        user = {
          name = "saberzero1";
          email = "github@emilebangma.com";
        };
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
    diff-so-fancy = {
      enable = true;
      settings = {
        changeHunkIndicators = true;
        markEmptyLines = true;
        pagerOpts = "--tabs=4 -RFX";
        stripLeadingSymbols = true;
        useUnicodeRuler = true;
      };
      enableGitIntegration = true;
    };

  };
}
