{ lib, ... }:
let
  lua = lib.mkLuaInline;
in
{
  programs.nvf.settings.vim.navigation = {
    harpoon = {
      enable = true;
    };
  };
  programs.nvf.settings.vim.minimap = {
    minimap-vim = {
      enable = false;
    };
    codewindow = {
      enable = true;
    };
  };
  programs.nvf.settings.vim.utility.snacks-nvim.setupOpts = {
    dashboard = {
      enabled = false;
    };
    bigfile = {
      enabled = true;
    };
    quickfile = {
      enabled = true;
    };
    terminal = {
      win = {
        keys = lua ''
          {
            nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
            nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
            nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
            nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
          }
        '';
      };
    };
    indent = {
      enabled = true;
    };
    input = {
      enabled = true;
    };
    notifier = {
      enabled = true;
    };
    scope = {
      enabled = true;
    };
    scroll = {
      enabled = true;
    };
    statuscolumn = {
      enabled = true;
    };
    toggle = {
      enabled = true;
    };
    words = {
      enabled = true;
    };
    picker = {
      enabled = true;
      ui_select = true;
    };
  };
  programs.nvf.settings.vim.keymaps = [
    {
      key = "<leader>.";
      action = "function() Snacks.scratch() end";
      lua = true;
      mode = "n";
      desc = "Toggle Scratch Buffer";
    }
    {
      key = "<leader>S";
      action = "function() Snacks.scratch.select() end";
      lua = true;
      mode = "n";
      desc = "Select Scratch Buffer";
    }
    {
      key = "<leader>dps";
      action = "function() Snacks.profiler.scratch() end";
      lua = true;
      mode = "n";
      desc = "Profiler Scratch Buffer";
    }
  ];
  programs.nvf.settings.vim.telescope = {
    enable = true;
    extensions = [
      {
        name = "yank_history";
        setup = {
          yank_history = { };
        };
      }
    ];
  };
}
