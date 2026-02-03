{ flake, pkgs, ... }:
{
  gtk = {
    enable = true;
    colorScheme = "dark";
    # cursorTheme = {
    #   name = "default";
    #   package = pkgs.tokyonight-gtk-theme;
    #   size = 24;
    # };
    iconTheme = {
      name = "Dark";
      package = pkgs.tokyonight-gtk-theme;
    };
    theme = {
      name = "storm";
      package = pkgs.tokyonight-gtk-theme;
    };
  };
}
