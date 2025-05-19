{ flake, pkgs, ... }:
{
  services.aerospace = {
    enable = false;
    package = pkgs.aerospace;
    settings = pkgs.lib.importTOML "${flake.inputs.dotfiles}/aerospace/aerospace.toml";
  };
}
