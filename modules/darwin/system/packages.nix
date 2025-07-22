{ pkgs, ... }:
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
