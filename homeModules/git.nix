{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
let
  config = pkgs.lib.mkMerge [
    (pkgs.lib.mkIf (config.networking.hostName == "nixos") {
      programs.git.signing.key = null;
    })
    (pkgs.lib.mkIf (config.networking.hostName == "croire") {
      programs.git.signing.key = null;
    })
    (pkgs.lib.mkIf (config.networking.hostName == "croire-low") {
      programs.git.signing.key = "46D5EEEA8690F388";
    })
  ];
in
  config = {
    home = {
      packages = [
        pkgs.diff-so-fancy
        pkgs.gh
      ];
    };
    programs = {
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
        signing = {
          signByDefault = true;
        };
        userEmail = "github@emilebangma.com";
        userName = "saberzero1";
      };
      gh = {
        enable = true;
        package = pkgs.gh;
        gitCredentialHelper = {
          enable = true;
          hosts = [
            "https://github.com"
            "https://gist.github.com"
          ];
        };
        extensions = [
          pkgs.gh-dash
        ];
      };
    };
  };
}
