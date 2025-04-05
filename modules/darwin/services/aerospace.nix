{ flake, pkgs, ... }:
{
  services.aerospace = {
    enable = true;
    package = pkgs.aerospace;
    settings = pkgs.lib.importTOML "${flake.inputs.dotfiles}/aerospace/aerospace.toml";
  };
}
