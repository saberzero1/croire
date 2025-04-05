{ flake, pkgs, ... }:
{
  services.skhd = {
    enable = true;
    skhdConfig = pkgs.lib.strings.fileContents "${flake.inputs.dotfiles}/skhd/skhdrc";
  };
}
