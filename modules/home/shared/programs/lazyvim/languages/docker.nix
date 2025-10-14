{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.docker.enable = true;
    };

    extraPackages = with pkgs; [
      hadolint
    ];
  };
}
