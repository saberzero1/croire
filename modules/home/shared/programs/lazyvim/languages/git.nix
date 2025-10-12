{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.git.enable = true;
    };

    extraPackages = with pkgs; [
      git
    ];
  };
}
