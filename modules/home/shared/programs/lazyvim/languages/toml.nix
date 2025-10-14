{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.toml.enable = true;
    };
  };
}
