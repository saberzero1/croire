{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.java.enable = true;
    };

    treesitterParsers = with pkgs.tree-sitter-grammars; [
      tree-sitter-java
    ];

    extraPackages = with pkgs; [
      jdk
      maven
      gradle
    ];
  };
}
