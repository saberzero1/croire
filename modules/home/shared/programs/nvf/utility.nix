{ ... }:
{
  programs.nvf.settings.vim.utility = {
    direnv = {
      enable = true;
    };
    multicursors = {
      enable = false;
    };
    surround = {
      enable = true;
    };
    undotree = {
      enable = true;
    };
    yanky-nvim = {
      enable = true;
      setupOpts = {
        ring.storage = "sqlite";
      };
    };
  };
}
