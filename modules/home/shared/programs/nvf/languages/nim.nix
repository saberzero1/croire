{ pkgs, ... }:
{
  programs.nvf.settings.vim.languages.nim = {
    enable = pkgs.stdenv.isLinux;
    format = {
      enable = true;
      type = "nimpretty";
    };
    lsp = {
      enable = true;
      server = "nimlsp";
    };
    treesitter = {
      enable = true;
    };
  };
}
