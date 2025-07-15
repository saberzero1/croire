{ pkgs, ... }:
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

    plugins = {
      "chmod" = pkgs.yaziPlugins.chmod;
      "git" = pkgs.yaziPlugins.git;
      "lazygit" = pkgs.yaziPlugins.lazygit;
      "relative-motions" = pkgs.yaziPlugins.relative-motions;
      "restore" = pkgs.yaziPlugins.restore;
      "starship" = pkgs.yaziPlugins.starship;
      "sudo" = pkgs.yaziPlugins.sudo;
      "ouch" = pkgs.yaziPlugins.ouch;
    };
  };
}
