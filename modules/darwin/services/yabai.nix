{ flake, pkgs, ... }:
{
  services.yabai = {
    enable = false;
    enableScriptingAddition = false;
    config = { };
    extraConfig = pkgs.lib.strings.fileContents "${flake.inputs.dotfiles}/yabai/yabairc";
  };
}
