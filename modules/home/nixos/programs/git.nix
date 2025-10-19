{ pkgs, config, ... }:
{
  programs = {
    git = {
      signing = {
        key = null;
        signByDefault = true;
      };
      enable = true;
      package = pkgs.gitFull;
      ignores = [
        "*.swp"
      ];
      lfs = {
        enable = true;
      };
      /*
        signing = {
        # key = null;
        signByDefault = true;
        gpgPath = "${pkgs.gnupg}/bin/gpg2";
        };
      */
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
