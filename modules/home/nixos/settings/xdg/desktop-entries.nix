{ flake
, pkgs
, config
, ...
}:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  # https://icons8.com/icons/set/computer-hardware--style-fluency
  xdg.desktopEntries = {
    "nvim" = {
      name = "Neovim";
      comment = "Edit text files";
      icon = "nvim";
      exec = "${pkgs.wezterm}/bin/wezterm -e ${pkgs.neovim}/bin/nvim %F";
      categories = [ "Application" ];
      terminal = false;
      mimeType = [ "text/plain" ];
    };
    "ranger" = {
      name = "Ranger";
      comment = "TUI File Explorer";
      icon = "${self}/assets/icons/ssd.png";
      exec = "${pkgs.wezterm}/bin/wezterm -e ${pkgs.ranger}/bin/ranger %F";
      categories = [ "Application" ];
      terminal = false;
      mimeType = [ "text/plain" ];
    };
    "geforce-now-appimage" = {
      name = "GeForce NOW (AppImage)";
      comment = "Cloud Gaming";
      icon = "${config.home.homeDirectory}/AppImages/.icons/geforce_now.png";
      exec = "${pkgs.bash}/bin/bash -c ${config.home.homeDirectory}/AppImages/geforce_now";
      categories = [ "Application" ];
      terminal = false;
      mimeType = [ "text/plain" ];
    };
    "obsidian" = {
      name = "Obsidian";
      comment = "Knowledge Management";
      icon = "${self}/assets/icons/obsidian.png";
      exec = "${pkgs.obsidian}/bin/obsidian %U";
      categories = [ "Application" ];
      terminal = false;
      mimeType = [ "text/plain" ];
    };
    "shutdown" = {
      name = "Shutdown";
      comment = "Shutdown the system";
      icon = "${self}/assets/icons/shutdown.png";
      exec = "${pkgs.wezterm}/bin/wezterm -e shutdown --poweroff --no-wall 0";
      categories = [ "System" ];
      terminal = false;
    };
    "reboot" = {
      name = "Reboot";
      comment = "Reboot the system";
      icon = "${self}/assets/icons/restart.png";
      exec = "${pkgs.wezterm}/bin/wezterm -e reboot";
      categories = [ "System" ];
      terminal = false;
    };
    "tmux-sessionizer" = {
      name = "Tmux Sessionizer";
      comment = "Tmux Sessionizer";
      icon = "${self}/assets/icons/tmux.png";
      exec = "${pkgs.wezterm}/bin/wezterm -e ${config.home.homeDirectory}/.config/tmux/scripts/tmux-sessionizer";
      categories = [ "Application" ];
      terminal = false;
      mimeType = [ "text/plain" ];
    };
  };
}
