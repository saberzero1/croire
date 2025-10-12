{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.typescript.enable = true;
    };

    treesitterParsers = with pkgs.tree-sitter-grammars; [
      tree-sitter-typescript
      tree-sitter-tsx
    ];

    extraPackages = with pkgs; [
      nodejs_latest
      yarn
      typescript
      deno
      prettier
      eslint_d
      eslint
      bun
    ];
  };
}
