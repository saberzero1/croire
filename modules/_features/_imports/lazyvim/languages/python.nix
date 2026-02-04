{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.python = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
      };
    };

    extraPackages = with pkgs; [
      pyright
    ];
  };
}
