{ lib, pkgs, ... }:
let
  grammarPackages = with pkgs.tree-sitter-grammars; [
  builtins.attrNames
  (builtins.map (n: pkgs.tree-sitter-grammars.${n}))
  (builtins.filter (pkg: !pkg.meta.broken))
];
in
{
  imports = [
    ./languages
  ];

  programs.lazyvim.treesitterParsers = grammarPackages;
}
