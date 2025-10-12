{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.markdown.enable = true;
    };

    treesitterParsers = with pkgs.tree-sitter-grammars; [
      tree-sitter-markdown
    ];

    extraPackages = with pkgs; [
      pandoc
      prettier
      markdownlint-cli
    ];
  };
}
