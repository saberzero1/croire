{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.java = {
        enable = false;
        installDependencies = true;
        installRuntimeDependencies = true;
      };
    };

    extraPackages = with pkgs; [
      jdk
      maven
      gradle
    ];
  };
}
