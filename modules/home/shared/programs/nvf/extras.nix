{ pkgs, ... }:
{
  programs.nvf.settings.vim.extraPackages = with pkgs; [
    coreutils # provides grealpath for yazi
    fd
    fzf
    lazygit
    ripgrep
    rustup
    sqlfluff
  ];
}
