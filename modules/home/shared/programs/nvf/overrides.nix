{ pkgs, ... }:
{
  programs.nvf.settings.vim.pluginOverrides = {
    blink-cmp = pkgs.vimPlugins.blink-cmp;
  };
}
