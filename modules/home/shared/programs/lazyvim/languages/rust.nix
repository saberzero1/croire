{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.rust.enable = true;
    };

    treesitterParsers = with pkgs.tree-sitter-grammars; [
      tree-sitter-rust
    ];

    extraPackages = with pkgs; [
      rustup
      cargo
      rust-analyzer
      rustfmt
      clippy
    ];
  };
}
