{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.svelte.enable = true;
    };

    treesitterParsers = with pkgs.tree-sitter-grammars; [
      tree-sitter-svelte
    ];

    extraPackages = with pkgs; [
      svelte-language-server
    ];
  };
}
