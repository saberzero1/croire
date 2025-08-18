{ pkgs, ... }:
{
  programs.nvf.settings.vim.lazy.plugins."${pkgs.vimPlugins.hydra-nvim.pname}" = {
    enabled = true;
    package = pkgs.vimPlugins.hydra-nvim;
    setupOpts = { };
  };
}
