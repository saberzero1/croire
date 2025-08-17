{ ... }:
{
  programs.nvf.settings.vim = {
    languages.lua = {
      enable = true;
      format = {
        enable = true;
      };
      lsp = {
        enable = true;
      };
      treesitter = {
        enable = true;
      };
    };
  };
}
