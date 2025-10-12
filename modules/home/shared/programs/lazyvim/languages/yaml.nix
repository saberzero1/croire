{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.yaml.enable = true;
    };

    treesitterParsers = with pkgs.tree-sitter-grammars; [
      tree-sitter-yaml
    ];

    extraPackages = with pkgs; [
      yamllint
      yq
    ];
  };
}
