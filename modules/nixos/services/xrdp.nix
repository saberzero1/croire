{ ... }:
{
  services.xrdp = {
    enable = false;
    defaultWindowManager = "gnome-remote-desktop";
    openFirewall = false;
    port = 3389;
  };
}
