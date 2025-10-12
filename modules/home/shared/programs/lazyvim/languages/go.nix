{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.go.enable = true;
    };

    treesitterParsers = with pkgs.tree-sitter-grammars; [
      tree-sitter-go
    ];

    extraPackages = with pkgs; [
      go
      go-tools
      gopls
      delve
    ];
  };
}
