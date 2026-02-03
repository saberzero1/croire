{ pkgs, ... }:
{
  home.packages = with pkgs; [
    go
    gopls
    gofumpt
    goimports-reviser
    golint
    go-tools
    delve
  ];
}
