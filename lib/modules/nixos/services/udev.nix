{ pkgs, ... }:
{
  services.udev = {
    enable = true;
    path = [
      "${pkgs.coreutils-full}/bin"
    ];
  };
}
