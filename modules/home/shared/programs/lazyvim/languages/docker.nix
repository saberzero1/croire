{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.docker.enable = true;
    };

    treesitterParsers = with pkgs.tree-sitter-grammars; [
      tree-sitter-dockerfile
    ];

    extraPackages = with pkgs; [
      hadolint
    ];
  };
}
