{ pkgs, ... }:
{
  programs.nvf.settings.vim = {
    extraPackages = with pkgs; [
      fzf
      lazygit
      ripgrep
    ];
  };
}
