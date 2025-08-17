{ pkgs, ... }:
{
  programs.nvf.settings.vim = {
    languages.sql = {
      enable = true;
      dialect = "ansi";
      format = {
        enable = true;
        package = pkgs.sqlfluff;
        type = "sqlfluff";
      };
      lsp = {
        enable = true;
        package = pkgs.sqls;
        server = "sqls";
      };
      treesitter = {
        enable = true;
      };
    };
  };
}
