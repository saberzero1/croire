{ ... }:
{
  dconf.settings = {
    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/saberzero1/.assets/backgrounds/wallpaper.png";
      picture-uri-dark = "file:///home/saberzero1/.assets/backgrounds/wallpaper.png";
    };
    "org/gnome/shell" = {
      favorite-apps = [
        "ranger.desktop"
        "zen.desktop"
        "obsidian.desktop"
        "discord.desktop"
        "nvim.desktop"
      ];
    };
  };
}
