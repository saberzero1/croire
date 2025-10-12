{ pkgs, ... }:
{
  home.packages =
    (with pkgs.nodePackages_latest; [
      nodejs
      live-server
      typescript
      prettier
      eslint_d
      svelte-language-server
      typescript-language-server
      ts-node
      sass
      serve
      npm
      vscode-langservers-extracted
    ])
    ++ (with pkgs; [
      bun
    ]);
}
