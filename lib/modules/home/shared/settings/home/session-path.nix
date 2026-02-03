{ config, ... }:
{
  home.sessionPath = [
    "${config.home.homeDirectory}/.config/just"
    "${config.home.homeDirectory}/.config/tmux/scripts"
    "${config.home.homeDirectory}/.local/bin"
  ];
}
