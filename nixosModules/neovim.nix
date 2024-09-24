{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
      ];
    };
    programs = {
      neovim = {
        defaultEditor = true;
        enable = true;
        package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
        viAlias = true;
        vimAlias = true;
        withNodeJs = true;
        withPython3 = true;
        withRuby = true;
      };
    };
  };
}
