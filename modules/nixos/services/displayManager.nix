{ ... }:
{
  services.displayManager = {
    enable = true;
    gdm = {
      enable = true;
      wayland = true;
    };
  };
}
