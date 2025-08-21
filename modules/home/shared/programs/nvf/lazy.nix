{ pkgs, ... }:
let
  plugin = pkgs.vimPlugins;
in
{
  programs.nvf.settings.vim.lazy = {
    enable = true;
    enableLznAutoRequire = true;
    loader = "lz.n";
    plugins = {
      "${plugin.persistence-nvim.pname}" = {
        enabled = true;
        package = plugin.persistence-nvim;
        event = "BufReadPre";
        setupModule = "persistence";
      };
      "${plugin.vim-repeat.pname}" = {
        enabled = true;
        package = plugin.vim-repeat;
      };
    };
  };
}
