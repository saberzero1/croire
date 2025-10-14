{ lib, pkgs, ... }:
let
  grammarPackages = with pkgs; lib.pipe tree-sitter-grammars.sources [
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
