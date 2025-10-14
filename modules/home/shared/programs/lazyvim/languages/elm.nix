{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.elm.enable = true;
    };
  };
}
