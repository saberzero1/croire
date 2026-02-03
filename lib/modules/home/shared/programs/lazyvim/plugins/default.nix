{
  flake,
  lib,
  pkgs,
  ...
}:
let
  grammarPackages = builtins.attrValues pkgs.vimPlugins.nvim-treesitter-parsers;
  filterNonPackage = builtins.filter lib.isDerivation;
  filterBroken = builtins.filter (n: !n.meta.broken);
  filterEmpty = builtins.filter (n: n.pname or "" != "");
  allGrammars = filterEmpty (filterBroken (filterNonPackage grammarPackages));
in
{
  imports = flake.inputs.self.lib.croire.autoImport ./.;

  # programs.lazyvim.extraPackages =
  #   with pkgs.vimPlugins;
  #   [
  #     nvim-treesitter
  #     nvim-treesitter-textobjects
  #   ]
  #   ++ allGrammars;
  programs.lazyvim = {
    installCoreDependencies = true;
  };
}
