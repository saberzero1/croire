{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.zsh
        pkgs.zsh-you-should-use
        pkgs.zsh-vi-mode
        pkgs.wezterm
        pkgs.just
        inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
        pkgs.ranger
        pkgs.fastfetch
        pkgs.ffmpeg
        pkgs.gcc
        pkgs.gnuplot
        pkgs.hdparm
        pkgs.hplip
        pkgs.htop
        pkgs.imagemagick
        pkgs.mpv
        pkgs.pamixer
        pkgs.pandoc
        pkgs.pciutils
        pkgs.rsync
        pkgs.starship
        pkgs.unzip
        pkgs.usbutils
        pkgs.wget
        pkgs.zip
      ];
    };
    programs = {
      zsh = {
        enable = true;
        enableCompletion = true;
        enableLsColors = true;
      };
    };
    users = {
      defaultUserShell = pkgs.zsh;
    };
  };
}
