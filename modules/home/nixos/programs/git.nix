{ pkgs, config, ... }:
{
  programs.git = {
    signing = {
      key = null;
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
    userName = "saberzero1";
    userEmail = "github@emilebangma.com";
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
}
