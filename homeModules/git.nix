{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }:
let
  username = inputs.self.username;
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
        pkgs.lazygit
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
      lazygit = {
        enable = true;
        package = pkgs.lazygit;
        settings = {
          gui = {
            nerdFontsVersion = "3";
            theme = {
              activeBorderColor = [
                "#ff9e64"
                "bold"
              ];
              inactiveBorderColor = [
                "#29a4bd"
              ];
              searchingActiveBorderColor = [
                "#ff9e64"
                "bold"
              ];
              optionsTextColor = [
                "#7aa2f7"
              ];
              selectedLineBgColor = [
                "#2e3c64"
              ];
              cherryPickedCommitFgColor = [
                "#7aa2f7"
              ];
              cherryPickedCommitBgColor= [
                "#bb92f7"
              ];
              markedBaseCommitFgColor = [
                "#7aa2f7"
              ];
              markedBaseCommitBgColor = [
                "#e0af68"
              ];
              unstagedChangesColor = [
                "#db4b4b"
              ];
              defaultFgColor = [
                "#c0caf5"
              ];
            };
          };
        };
      };
    };
  };
}
