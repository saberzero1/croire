{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.luajit
        pkgs.lua53Packages.lua
        pkgs.lua53Packages.libluv
        pkgs.lua53Packages.argparse
        pkgs.lua53Packages.busted
        pkgs.lua53Packages.busted-htest
        pkgs.lua53Packages.commons-nvim
        pkgs.lua53Packages.compat53
        pkgs.lua53Packages.cosmo
        pkgs.lua53Packages.ldoc
        pkgs.lua53Packages.http
        pkgs.lua53Packages.image-nvim
        pkgs.lua53Packages.inspect
        pkgs.lua53Packages.jsregexp
        pkgs.lua53Packages.lua-lsp
        pkgs.lua53Packages.lua-utils-nvim
        pkgs.lua53Packages.luacheck
        pkgs.lua53Packages.luarocks
        pkgs.lua53Packages.luarocks-build-rust-mlua
        pkgs.lua53Packages.luarocks-build-treesitter-parser
        pkgs.lua53Packages.luasnip
        pkgs.lua53Packages.luasql-sqlite3
        pkgs.lua53Packages.luassert
        pkgs.lua53Packages.luasystem
        pkgs.lua53Packages.luatext
        pkgs.lua53Packages.luaunit
        pkgs.lua53Packages.luautf8
        pkgs.lua53Packages.luazip
        pkgs.lua53Packages.luuid
        pkgs.lua53Packages.luv
        pkgs.lua53Packages.lyaml
        pkgs.lua53Packages.markdown
        pkgs.lua53Packages.mediator_lua
        pkgs.lua53Packages.middleclass
        pkgs.lua53Packages.neorg
        # pkgs.lua53Packages.neotest
        pkgs.lua53Packages.nlua
        pkgs.lua53Packages.nui-nvim
        pkgs.lua53Packages.nvim-cmp
        pkgs.lua53Packages.nvim-nio
        pkgs.lua53Packages.pathlib-nvim
        pkgs.lua53Packages.penlight
        pkgs.lua53Packages.plenary-nvim
        pkgs.lua53Packages.readline
        pkgs.lua53Packages.rest-nvim
        pkgs.lua53Packages.rocks-config-nvim
        pkgs.lua53Packages.rocks-dev-nvim
        pkgs.lua53Packages.rocks-git-nvim
        pkgs.lua53Packages.rocks-nvim
        pkgs.lua53Packages.rtp-nvim
        pkgs.lua53Packages.say
        pkgs.lua53Packages.serpent
        pkgs.lua53Packages.std-_debug
        pkgs.lua53Packages.std-normalize
        pkgs.lua53Packages.stdlib
      ];
    };
  };
}
