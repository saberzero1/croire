{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    home = {
      packages = [
        pkgs.diff-so-fancy
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
    };
  };
}
