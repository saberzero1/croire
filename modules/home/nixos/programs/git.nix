{ pkgs, config, ... }:
let
  signingPublicKeyPath = "${config.home.homeDirectory}/.ssh/saberzero1-github.pub";
  signingPublicKey =
    if builtins.pathExists signingPublicKeyPath then pkgs.lib.readFile signingPublicKeyPath else null;
in
{
  programs = {
    git = {
      signing = {
        key = signingPublicKey;
        signByDefault = true;
        format = "ssh";
      };
      enable = true;
      package = pkgs.gitFull;
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
        tag.gpgsign = true;
        gpg.format = "ssh";
        user.signingkey = signingPublicKeyPath;
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
