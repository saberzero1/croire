{ pkgs, ... }:
{
  imports = [
    ./languages
  ];

  programs.lazyvim.treesitterParsers = with pkgs.tree-sitter-grammars; builtins.attrValues pkgs.tree-sitter-grammars;
}
