{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      diff-so-fancy
      gh
      lazygit
      git

      xcodes
      apple-sdk
    ];
  };
}
