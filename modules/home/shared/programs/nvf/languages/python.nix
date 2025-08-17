{ ... }:
{
  programs.nvf.settings.vim = {
    languages.python = {
      enable = true;
      format = {
        enable = true;
        type = "black";
      };
      lsp = {
        enable = true;
        server = "pyright";
      };
      treesitter = {
        enable = true;
      };
    };
  };
}
