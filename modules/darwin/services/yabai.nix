{ flake, pkgs, ... }:
{
  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    config = { };
    extraConfig = pkgs.lib.strings.fileContents "${flake.inputs.dotfiles}/yabai/yabairc";
  };
}
