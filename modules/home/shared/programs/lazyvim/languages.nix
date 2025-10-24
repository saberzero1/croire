{ lib, pkgs, ... }:
let
  grammarPlugins = builtins.attrValues pkgs.vimPlugins.nvim-treesitter.grammarPlugins;
  grammarPackages = builtins.attrValues pkgs.tree-sitter-grammars;
  filterNonPackage = builtins.filter lib.isDerivation;
  filterBroken = builtins.filter (n: !n.meta.broken);
  filterEmpty = builtins.filter (n: n.pname or "" != "");
  allGrammarPlugins = filterEmpty (filterBroken (filterNonPackage grammarPlugins));
  allGrammarPackages = filterEmpty (filterBroken (filterNonPackage grammarPackages));
in
{
  imports = [
    ./languages
  ];

  programs.lazyvim.extraPackages =
    with pkgs;
    [
      tree-sitter
    ]
    ++ allGrammarPackages
    ++ allGrammarPlugins;

  # programs.lazyvim.treesitterParsers = allGrammars;
}
