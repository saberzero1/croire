{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.toml.enable = true;
    };

    treesitterParsers = with pkgs.tree-sitter-grammars; [
      tree-sitter-toml
    ];
  };
}
