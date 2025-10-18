{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  environment = {
    systemPackages =
      with pkgs;
      [
        diff-so-fancy
        gh
        lazygit
        gitFull
        tree-sitter

        xcodes
        apple-sdk
        pre-commit

        bun

        # opencode

        # Sketchybar
        lua54Packages.lua
        sketchybar-app-font
        sbarlua

        ispell
      ]
      ++ (with pkgs.aspellDicts; [
        aspell-dict-en
        aspell-dict-nl
        aspell-dict-en-computers
        apsell-dict-en-science
      ])
      ++ (with pkgs.fonts; [
        font-mplus
        font-noto
        font-jetbrains-mono
        font-fira-code
        font-hack
        font-source-code-pro
      ]);
  };
}
