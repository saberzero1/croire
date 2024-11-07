{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.nodePackages.nodejs
        pkgs.nodePackages.typescript
        pkgs.nodePackages.prettier
        pkgs.nodePackages.eslint_d
        pkgs.nodePackages.svelte-language-server
        pkgs.nodePackages.typescript-language-server
        pkgs.nodePackages.ts-node
        pkgs.nodePackages.sass
        pkgs.nodePackages.serve
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
