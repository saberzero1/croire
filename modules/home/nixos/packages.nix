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
      wavebox
      ulauncher
      freerdp
      wl-clipboard

      # Extras
      hdparm
      # hplip
      htop
      imagemagick
      mpv
      pamixer
      pciutils
      usbutils

      atuin
      gh-dash
      xclicker

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
      python312Packages.pynvim

      # Lua
      luajit

      # VSCopium
      vscode-extensions.asvetliakov.vscode-neovim
      vscodium.fhs

      # Espanso
      espanso-wayland
    ]
    ++ [
      flake.inputs.zen-browser.packages."x86_64-linux".default
    ];
}
