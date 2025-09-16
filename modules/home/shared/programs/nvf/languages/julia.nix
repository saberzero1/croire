{ pkgs, ... }:
{
  programs.nvf.settings.vim.languages.julia = {
    enable = pkgs.stdenv.isLinux;
    lsp = {
      enable = pkgs.stdenv.isLinux;
      server = "julials";
    };
  };
}
