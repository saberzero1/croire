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
      appflowy = pkgs.appflowy.overrideDerivation (oldAttrs: {
        version = "0.5.1";
        src = fetchzip {
          url = "https://github.com/AppFlowy-IO/appflowy/releases/download/${version}/AppFlowy-${version}-linux-x86_64.tar.gz";
          hash = "sha256-HET65l+DnSzSu3ZpwJHJ3aRE6WRPW/S/d9aiEy/Onhk=";
          stripRoot = false;
        };
      });
    };
    services = {
      espanso = {
        enable = true;
      };
    };
  };
}
