{ pkgs, ... }:
{
  imports = [
    ./languages
  ];

  programs.lazyvim.treesitterParsers = builtins.attrValues pkgs.tree-sitter-grammars;
}
