{ pkgs, ... }:
{
  programs.nvf.settings.vim.languages.julia = {
    enable = false;
    lsp = {
      enable = false;
      servers = "julials";
    };
  };
}
