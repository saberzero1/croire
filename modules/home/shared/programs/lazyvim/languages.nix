{ lib, pkgs, ... }:
let
  grammarPackages = builtins.attrValues pkgs.vimPlugins.nvim-treesitter.grammarPlugins;
  filterNonPackage = builtins.filter lib.isDerivation;
  filterBroken = builtins.filter (n: !n.meta.broken);
  filterEmpty = builtins.filter (n: n.pname or "" != "");
  allGrammars = filterEmpty (filterBroken (filterNonPackage grammarPackages));
in
{
  imports = [
    ./languages
  ];

  # programs.lazyvim.treesitterParsers = allGrammars;
}
