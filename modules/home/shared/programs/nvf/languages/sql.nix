{ ... }:
{
  programs.nvf.settings.vim = {
    languages.sql = {
      enable = true;
      format = {
        enable = true;
        type = "sqlfluff";
      };
      lsp = {
        enable = true;
        server = "sqls";
      };
      treesitter = {
        enable = true;
      };
    };
  };
}
