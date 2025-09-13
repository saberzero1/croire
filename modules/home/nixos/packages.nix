{ pkgs
, flake
, ...
}:
{
  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages =
    with pkgs;
    [
      # wavebox
      # ladybird
      ulauncher
      freerdp
      wl-clipboard
      wezterm

      gearlever
      appimage-run

      # Extras
      hdparm
      # hplip
      htop
      imagemagick
      mpv
      pamixer
      pciutils
      usbutils
      lsof

      atuin
      gh-dash
      xclicker
      # thefuck

      # Backup and Sync
      pika-backup
      restic
      rclone
      rclone-browser

      # Encryption
      age-plugin-yubikey
      sops
      yubikey-touch-detector

      # Python
      python3
      python3Packages.pynvim

      # Lua
      luajit

      # VSCopium
      vscode-extensions.asvetliakov.vscode-neovim
      vscodium.fhs

      # Espanso
      espanso-wayland

      # Graphic Drivers
      driversi686Linux.amdvlk

      # Miscellaneous
      calibre

      # Sway
      swaylock
      swayidle
      wl-clipboard
      wf-recorder
      sway-contrib.grimshot
      mako # notification daemon
      grim
      slurp
      alacritty # Alacritty is the default terminal in the config
      dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
      wofi
      gtk-engine-murrine
      gtk_engines
      gsettings-desktop-schemas
      lxappearance
      kdePackages.dragon
      swappy
      xdg-utils
      uwsm

      evince
      foliate
      pulseaudioFull
      avizo
      libnotify
      fuzzel

      steam
      discord
    ]
    ++ (with flake.inputs; [
      zen-browser.packages."x86_64-linux".twilight
      nix-alien.packages."x86_64-linux".nix-alien
    ]);
}
