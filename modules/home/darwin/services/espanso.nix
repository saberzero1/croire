{ pkgs, lib, ... }:
{
  services.espanso = {
    enable = lib.mkForce true;
    package = lib.mkForce pkgs.espanso;
  };
}
