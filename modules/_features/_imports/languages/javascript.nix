{ pkgs, ... }:
{
  home.packages =
    (with pkgs.nodePackages; [
      typescript
      prettier
      eslint_d
      svelte-language-server
      typescript-language-server
      sass
      serve
      npm
      vscode-langservers-extracted
    ])
    ++ (with pkgs; [
      bun
    ]);
}
