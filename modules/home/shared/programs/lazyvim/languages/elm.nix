{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.elm.enable = true;
    };

    treesitterParsers = with pkgs.tree-sitter-grammars; [
      tree-sitter-elm
    ];
  };
}
