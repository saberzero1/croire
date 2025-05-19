{ flake, pkgs, ... }:
{
  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    config = pkgs.lib.strings.fileContents "${flake.inputs.dotfiles}/skhd/skhdrc";
  };
}
