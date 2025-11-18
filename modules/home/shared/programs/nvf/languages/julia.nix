{ pkgs, ... }:
{
  programs.nvf.settings.vim.languages.julia = {
    enable = false;
    lsp = {
      enable = pkgs.stdenv.isLinux;
      servers = [ "julials" ];
    };
  };
}
