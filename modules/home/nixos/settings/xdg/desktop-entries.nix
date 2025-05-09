{ flake
, pkgs
, config
, ...
}:
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
      icon = "${flake.inputs.dotfiles}/assets/icons/ssd.png";
      exec = "${pkgs.wezterm}/bin/wezterm -e ${pkgs.ranger}/bin/ranger %F";
      categories = [ "Application" ];
      terminal = false;
      mimeType = [ "text/plain" ];
    };
    "geforce-now" = {
      name = "GeForce NOW";
      comment = "Cloud Gaming";
      icon = "geforcenow-electron";
      exec = "/snap/bin/geforcenow-electron";
      categories = [ "Application" ];
      terminal = false;
      mimeType = [ "text/plain" ];
    };
    "obsidian" = {
      name = "Obsidian";
      comment = "Knowledge Management";
      icon = "${flake.inputs.dotfiles}/assets/icons/obsidian.png";
      exec = "${pkgs.obsidian}/bin/obsidian %U";
      categories = [ "Application" ];
      terminal = false;
      mimeType = [ "text/plain" ];
    };
    "shutdown" = {
      name = "Shutdown";
      comment = "Shutdown the system";
      icon = "${flake.inputs.dotfiles}/assets/icons/shutdown.png";
      exec = "${pkgs.wezterm}/bin/wezterm -e power-down";
      categories = [ "System" ];
      terminal = false;
    };
    "reboot" = {
      name = "Reboot";
      comment = "Reboot the system";
      icon = "${flake.inputs.dotfiles}/assets/icons/restart.png";
      exec = "${pkgs.wezterm}/bin/wezterm -e reboot";
      categories = [ "System" ];
      terminal = false;
    };
    "tmux-sessionizer" = {
      name = "Tmux Sessionizer";
      comment = "Tmux Sessionizer";
      icon = "${flake.inputs.dotfiles}/assets/icons/tmux.png";
      exec = "${pkgs.wezterm}/bin/wezterm -e ${config.home.homeDirectory}/.config/tmux/scripts/tmux-sessionizer";
      categories = [ "Application" ];
      terminal = false;
      mimeType = [ "text/plain" ];
    };
  };
}
