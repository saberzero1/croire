{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.erlang = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
      };
    };

    extraPackages = with pkgs; [
      erlang
    ];
  };
}
