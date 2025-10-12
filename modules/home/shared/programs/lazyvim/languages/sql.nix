{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.sql.enable = true;
    };

    treesitterParsers = with pkgs.tree-sitter-grammars; [
      tree-sitter-sql
    ];

    extraPackages = with pkgs; [
      sql-formatter
      sqlfluff
      sqlint
      pgcli
      mycli
    ];
  };
}
