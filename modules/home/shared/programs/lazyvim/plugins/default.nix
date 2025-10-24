{ lib, pkgs, ... }:
let
  grammarPackages = builtins.attrValues pkgs.vimPlugins.nvim-treesitter-parsers;
  filterNonPackage = builtins.filter lib.isDerivation;
  filterBroken = builtins.filter (n: !n.meta.broken);
  filterEmpty = builtins.filter (n: n.pname or "" != "");
  allGrammars = filterEmpty (filterBroken (filterNonPackage grammarPackages));
in
{
  imports = builtins.map (fn: ./${fn}) (
    builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir ./.))
  );

  programs.lazyvim.extraPackages =
    # with pkgs.vimPlugins;
    # [
    #   nvim-treesitter
    #   nvim-treesitter-textobjects
    # ] ++
    allGrammars;
}
