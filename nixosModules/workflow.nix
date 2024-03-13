{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.ulauncher
        pkgs.freerdp
        pkgs.espanso
        pkgs.appflowy
      ];
    };
    appflowy = super.appflowy.overrideAttrs ( old: rec {
      pname = "appflowy";
      version = "0.5.1";
      src = super.fetchzip {
        url = "https://github.com/AppFlowy-IO/appflowy/releases/download/${version}/AppFlowy-${version}-linux-x86_64.tar.gz";
        sha256 = "sha256-HET65l+DnSzSu3ZpwJHJ3aRE6WRPW/S/d9aiEy/Onhk=";
      };
    });
    services = {
      espanso = {
        enable = true;
      };
    };
  };
}
