{ pkgs
, lib
, config
, ...
}:
{
  imports = [
    ./flatpak.nix
    ./fstrim.nix
    ./gnome.nix
    ./greetd.nix
    ./openssh.nix
    ./pipewire.nix
    ./printing.nix
    ./prometheus.nix
    ./restic.nix
    ./udev.nix
    ./xrdp.nix
    ./xserver.nix
    ./yubikey-agent.nix
  ];

}
