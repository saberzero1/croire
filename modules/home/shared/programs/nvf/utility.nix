{ ... }:
{
  programs.nvf.settings.vim.utility = {
    direnv = {
      enable = true;
    };
    motion = {
      hop = {
        enable = true;
      };
      leap = {
        enable = true;
      };
      precognition = {
        enable = true;
      };
    };
    multicursors = {
      enable = false;
    };
    snacks-nvim = {
      enable = true;
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
