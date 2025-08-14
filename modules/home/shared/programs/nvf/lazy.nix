{ pkgs, ... }:
{
  programs.nvf.settings.vim.lazy = {
    enable = true;
    enableLznAutoRequire = true;
    loader = "lz.n";
    plugins = {
      "${pkgs.vimPlugins.persistence-nvim.pname}" = {
        enabled = true;
        package = pkgs.vimPlugins.persistence-nvim;
        event = "BufReadPre";
        setupModule = "persistence";
      };
    };
  };
}
