{ config, ... }:
{
  home.sessionPath = [
    "${config.home.homeDirectory}/.config/tmux/scripts"
    "${config.home.homeDirectory}/.local/bin"
  ];
}
