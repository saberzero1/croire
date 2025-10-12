{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.python.enable = true;
    };

    treesitterParsers = with pkgs.tree-sitter-grammars; [
      tree-sitter-python
    ];

    extraPackages = with pkgs; [
      pyright
    ];
  };
}
