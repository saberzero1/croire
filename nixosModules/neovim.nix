{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    programs = {
      neovim = {
        defaultEditor = true;
        enable = true;
        package = pkgs.neovim;
        viAlias = true;
        vimAlias = true;
        withNodeJs = true;
        withPython3 = true;
        withRuby = true;
      };
    };
  };
}
