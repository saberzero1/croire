{ flake, pkgs, ... }:
{
  services = {
    aerospace = {
      enable = true;
      package = pkgs.aerospace;
      settings = pkgs.lib.importTOML "${flake.inputs.dotfiles}/aerospace/aerospace.toml";
    };
    yabai = {
      enable = false;
      enableScriptingAddition = false;
      config = { };
      extraConfig = pkgs.lib.strings.fileContents "${flake.inputs.dotfiles}/yabai/yabairc";
    };
    skhd = {
      enable = true;
      skhdConfig = pkgs.lib.strings.fileContents "${flake.inputs.dotfiles}/skhd/skhdrc";
    };
  };
}
