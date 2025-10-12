{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.json.enable = true;
    };

    treesitterParsers = with pkgs.tree-sitter-grammars; [
      tree-sitter-json
    ];

    extraPackages = with pkgs; [
      jq
    ];
  };
}
