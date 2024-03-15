{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }:
let
  config = pkgs.lib.mkMerge [
    # Configure key name per device.
    #
    # Use gpg2.
    # 
    # gpg2 --full-generate-key
    # gpg2 --list-secret-keys --keyid-format=long 
    # gpg2 --armor --export 1234567890ABCDEF
    (pkgs.lib.mkIf (config.networking.hostName == "nixos") {
      config.programs.git.signing.key = "41AEE99107640F10";
    })
    (pkgs.lib.mkIf (config.networking.hostName == "croire") {
      config.programs.git.signing.key = null;
    })
    (pkgs.lib.mkIf (config.networking.hostName == "croire-low") {
      config.programs.git.signing.key = "198769D1B0D0DF8C";
    })
  ];
in
{
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
          key = null;
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
