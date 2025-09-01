{ ... }:
{
  programs.nvf.settings.vim.utility = {
    direnv = {
      enable = true;
    };
    motion = {
      hop = {
        enable = false;
      };
      leap = {
        enable = false;
      };
      precognition = {
        enable = true;
        setupOpts = {
          disabled_fts = [
            "alpha"
            "dashboard"
            "ministarter"
            "snacks_dashboard"
            "startify"
          ];
        };
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
  };
}
