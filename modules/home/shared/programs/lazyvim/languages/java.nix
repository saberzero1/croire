{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.java.enable = true;
    };

    extraPackages = with pkgs; [
      jdk
      maven
      gradle
    ];
  };
}
