{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  environment = {
    systemPackages = with pkgs; [
      diff-so-fancy
      gh
      lazygit
      gitFull

      xcodes
      apple-sdk

      bun

      opencode
    ];
  };
}
