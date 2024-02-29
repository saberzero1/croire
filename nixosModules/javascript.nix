{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.nodePackages.nodejs
        pkgs.nodePackages.typescript
        pkgs.nodePackages.prettier
      ];
    };
    programs = {
      npm = {
        enable = true;
        npmrc = ''
          '''
            prefix = '''''${HOME}/.npm
            color=true
          '''
        '';
      };
    };
  };
}
