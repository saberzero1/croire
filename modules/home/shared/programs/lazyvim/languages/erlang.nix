{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.erlang.enable = true;
    };

    treesitterParsers = with pkgs.tree-sitter-grammars; [
      tree-sitter-erlang
    ];

    extraPackages = with pkgs; [
      erlang
    ];
  };
}
