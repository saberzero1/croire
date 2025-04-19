{ pkgs, ... }:
{
  xdg.desktopEntries = {
    "nvim" = {
      name = "nvim";
      comment = "Edit text files";
      icon = "nvim";
      exec = "${pkgs.wezterm}/bin/wezterm -e ${pkgs.neovim}/bin/nvim %F";
      categories = [ "Application" ];
      terminal = false;
      mimeType = [ "text/plain" ];
    };
    "explorer" = {
      name = "explorer";
      comment = "TUI File Explorer";
      icon = "ranger";
      exec = "${pkgs.wezterm}/bin/wezterm -e ${pkgs.ranger}/bin/ranger %F";
      categories = [ "Application" ];
      terminal = false;
      #mimeType = [ "text/plain" ];
    };
    "geforce-now" = {
      name = "GeForce NOW";
      comment = "Cloud Gaming";
      icon = "geforcenow-electron";
      exec = "/snap/bin/geforcenow-electron";
      categories = [ "Application" ];
      terminal = false;
      #mimeType = [ "text/plain" ];
    };
  };
}
