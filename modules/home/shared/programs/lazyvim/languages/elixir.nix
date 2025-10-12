{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.elixir.enable = true;
    };

    treesitterParsers = with pkgs.tree-sitter-grammars; [
      tree-sitter-elixir
    ];

    extraPackages = with pkgs; [
      elixir
      elixir-ls
    ];
  };
}
