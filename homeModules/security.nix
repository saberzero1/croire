{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    home = {
      packages = [
        pkgs.gnupg
        pkgs.sshpass
      ];
    };
    programs = {
      git = {
        signing = {
          gpgPath = "\\\${pkgs.gnupg}/bin/gpg2";
        };
      };
    };
  };
}
