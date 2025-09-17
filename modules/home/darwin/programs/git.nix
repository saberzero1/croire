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

  programs.git = {
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
    userName = "saberzero1";
    userEmail = "github@emilebangma.com";
    includes =
      if isDarwin then
        [
          {
            path = "${config.home.homeDirectory}/work_gitconfig";
            condition = "gitdir:~/Work/External/Repos/**";
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
