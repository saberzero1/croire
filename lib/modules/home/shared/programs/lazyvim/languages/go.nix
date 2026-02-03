{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.go = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
      };
    };

    extraPackages = with pkgs; [
      go
      go-tools
      gopls
      delve
    ];
  };
}
