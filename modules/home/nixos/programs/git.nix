{ pkgs, ... }:
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
    package = pkgs.git;
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
    userEmail = "github@emilebangma.com";
    userName = "saberzero1";
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
}
