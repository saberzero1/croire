{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.zsh
        pkgs.zsh-autosuggestions
        pkgs.zsh-completions
        pkgs.zsh-syntax-highlighting
        pkgs.zsh-vi-mode
        pkgs.zsh-you-should-use
        pkgs.wezterm
        pkgs.just
        pkgs.tmux
        pkgs.monaspace
        pkgs.starship
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
        pkgs.thefuck
      ];
    };
    programs = {
      zsh = {
        enable = true;
        enableCompletion = true;
        enableLsColors = true;
      };
      thefuck = {
        enable = true;
        aias = "fuck";
      };
    };
    users = {
      defaultUserShell = pkgs.zsh;
    };
  };
}
