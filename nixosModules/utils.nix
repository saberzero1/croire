{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.gnugrep
        pkgs.gnused
        pkgs.curlFull
        pkgs.iwgtk
        pkgs.iperf2
        pkgs.sshpass
        pkgs.uget
        pkgs.wget2
        pkgs.gnumake
        pkgs._7zz
      ];
    };
  };
}
