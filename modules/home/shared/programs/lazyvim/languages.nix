{ lib, pkgs, ... }:
let
  grammarPackages = lib.pipe pkgs.tree-sitter-grammars [
  builtins.attrNames
  (builtins.map (n: tree-sitter-grammars.${n}))
  (builtins.filter (pkg: !pkg.meta.broken))
];
in
{
  imports = [
    ./languages
  ];

  programs.lazyvim.treesitterParsers = grammarPackages;
}
