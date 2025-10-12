{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.ruby.enable = true;
    };

    treesitterParsers = with pkgs.tree-sitter-grammars; [
      tree-sitter-ruby
    ];

    extraPackages = with pkgs; [
      ruby
    ];
  };
}
