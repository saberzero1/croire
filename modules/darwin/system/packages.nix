{ pkgs, ... }:
{
  environment = {
    systemPackages =
      with pkgs;
      [
        diff-so-fancy
        gh
        lazygit
        git

        xcodes
      ]
      ++ (with pkgs.darwin.apple_sdk.frameworks; [
        AppKit
        CoreServices
        Foundation
        IOKit
        Security
        SystemConfiguration
      ]);
  };
}
