{
  programs.nvf.settings.vim.languages.sql = {
    enable = true;
    dialect = "ansi";
    extraDiagnostics = {
      enable = true;
      types = [ "sqlfluff" ];
    };
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
}
