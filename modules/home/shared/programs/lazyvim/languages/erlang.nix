{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.erlang.enable = true;
    };

    extraPackages = with pkgs; [
      erlang
    ];
  };
}
