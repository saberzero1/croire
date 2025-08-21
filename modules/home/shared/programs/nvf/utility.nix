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
      flash-nvim = {
        enable = true;
        mappings = {
          jump = "s";
          treesitter = "S";
          remote = "r";
          treesitter_search = "R";
          toggle = "<c-s>";
        };
        setupOpts = { };
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
    yanky-nvim = {
      enable = true;
      setupOpts = {
        ring.storage = "sqlite";
      };
    };
  };
}
