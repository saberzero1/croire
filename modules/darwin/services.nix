{ pkgs, inputs, ... }:
{
  services = {
    aerospace = {
      enable = true;
      package = pkgs.aerospace;
      settings = pkgs.lib.importTOML "${inputs.dotfiles}/aerospace/aerospace.toml";
    };
  };
}
