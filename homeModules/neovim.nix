{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    home = {
      packages = [
        pkgs.vimPlugins.coc-nvim
        pkgs.vimPlugins.nvim-treesitter-parsers.bash
        pkgs.vimPlugins.nvim-treesitter-parsers.c
        pkgs.vimPlugins.nvim-treesitter-parsers.c_sharp
        pkgs.vimPlugins.nvim-treesitter-parsers.cpp
        pkgs.vimPlugins.nvim-treesitter-parsers.css
        pkgs.vimPlugins.nvim-treesitter-parsers.dockerfile
        pkgs.vimPlugins.nvim-treesitter-parsers.go
        pkgs.vimPlugins.nvim-treesitter-parsers.java
        pkgs.vimPlugins.nvim-treesitter-parsers.javascript
        pkgs.vimPlugins.nvim-treesitter-parsers.json
        pkgs.vimPlugins.nvim-treesitter-parsers.jsonc
        pkgs.vimPlugins.nvim-treesitter-parsers.lua
        pkgs.vimPlugins.nvim-treesitter-parsers.nix
        pkgs.vimPlugins.nvim-treesitter-parsers.regex
        pkgs.vimPlugins.nvim-treesitter-parsers.python
        pkgs.vimPlugins.nvim-treesitter-parsers.ruby
        pkgs.vimPlugins.nvim-treesitter-parsers.rust
        pkgs.vimPlugins.nvim-treesitter-parsers.sql
        pkgs.vimPlugins.nvim-treesitter-parsers.typescript
        pkgs.vimPlugins.nvim-treesitter-parsers.vim
        pkgs.vimPlugins.nvim-treesitter-parsers.xml
        pkgs.vimPlugins.nvim-treesitter-parsers.yaml
        pkgs.vimPlugins.nvim-treesitter-parsers.zig
        pkgs.vimPlugins.nvim-cmp
      ];
    };
    programs = {
      neovim = {
        defaultEditor = true;
        enable = true;
        viAlias = true;
        vimAlias = true;
        withNodeJs = true;
        withPython3 = true;
        withRuby = true;
      };
    };
  };
}
