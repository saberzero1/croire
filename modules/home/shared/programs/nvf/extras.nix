{ pkgs, ... }:
{
  programs.nvf.settings.vim.extraPackages = with pkgs; [
    fd
    fzf
    lazygit
    ripgrep
    rustup
  ];
}
