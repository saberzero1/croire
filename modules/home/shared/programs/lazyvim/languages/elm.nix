{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.elm = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
      };
    };

    extraPackages = with pkgs.elmPackages; [
      elm-format
    ];
  };
}
