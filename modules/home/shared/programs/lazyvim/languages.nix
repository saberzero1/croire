{ lib, pkgs, ... }:
let
  grammarPackages = builtins.attrValues pkgs.tree-sitter-grammars;
  filterNonPackage = builtins.filter lib.isDerivation;
  filterBroken = builtins.filter (n: !n.meta.broken);
  allGrammars = filterBroken (filterNonPackage grammarPackages);
in
{
  imports = [
    ./languages
  ];

  programs.lazyvim.treesitterParsers = allGrammars;
}
