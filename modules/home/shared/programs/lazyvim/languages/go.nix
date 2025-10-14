{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.go.enable = true;
    };

    extraPackages = with pkgs; [
      go
      go-tools
      gopls
      delve
    ];
  };
}
