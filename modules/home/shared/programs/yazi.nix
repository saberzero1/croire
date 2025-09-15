{ pkgs, ... }:
let
  plugins = [
    "chmod"
    "git"
    "lazygit"
    "relative-motions"
    "restore"
    "starship"
    "sudo"
    "ouch"
  ];
  pluginMap = builtins.listToAttrs (
    map
      (plugin: {
        name = plugin;
        value = pkgs.yaziPlugins.${plugin};
      })
      plugins
  );
in
{
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;

    enableBashIntegration = true;
    enableZshIntegration = true;

    settings = { };

    theme = builtins.fromTOML ''
      [flavor]
      use = "tokyo-night"
      dark = "tokyo-night"
    '';
    plugins = pluginMap;
  };
}
