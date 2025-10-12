{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.nix.enable = true;
    };

    treesitterParsers = with pkgs.tree-sitter-grammars; [
      tree-sitter-nix
    ];

    extraPackages = with pkgs; [
      nixd
      nixpkgs-fmt
      alejandra
    ];
  };
}
