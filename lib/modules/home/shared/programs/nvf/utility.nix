{ pkgs, ... }:
let
  plugin = pkgs.vimPlugins;
in
{
  programs.nvf.settings.vim.lazy.plugins = {
    "grug-far.nvim" = {
      enabled = true;
      package = plugin.grug-far-nvim;
      cmd = "GrugFar";
      setupOpts = { };
      keys = [
        {
          key = "<leader>sr";
          action = ''
            function()
              local grug = require("grug-far")
              local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
              grug.open({
                transient = true,
                prefills = {
                  filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                },
              })
            end
          '';
          lua = true;
          mode = [
            "n"
            "v"
          ];
          desc = "Search and Replace";
        }
      ];
    };
    "plenary-nvim" = {
      enabled = true;
      package = "plenary-nvim";
      lazy = false;
    };
    "yanky-nvim" = {
      enabled = true;
      lazy = true;
      package = "yanky-nvim";
      setupModule = "yanky";
      setupOpts = {
        ring.storage = "sqlite";
        highlight = {
          on_put = true;
          on_yank = true;
          timer = 150;
        };
        picker = {
          telescope = {
            use_default_mappings = true;
          };
        };
      };
      keys = [
        {
          key = "<leader>p";
          mode = [
            "n"
            "x"
          ];
          action = ''
            function()
              local picker = require("telescope")
              if picker ~= nil then
                picker.extensions.yank_history.yank_history({})
              end
            end
          '';
          lua = true;
          desc = "Open Yank History";
        }
        {
          key = "y";
          mode = [
            "n"
            "x"
          ];
          action = "<Plug>(YankyYank)";
          desc = "Yank Text";
        }
        {
          key = "p";
          mode = [
            "n"
            "x"
          ];
          action = "<Plug>(YankyPutAfter)";
          desc = "Put Text After Cursor";
        }
        {
          key = "P";
          mode = [
            "n"
            "x"
          ];
          action = "<Plug>(YankyPutBefore)";
          desc = "Put Text Before Cursor";
        }
        {
          key = "gp";
          mode = [
            "n"
            "x"
          ];
          action = "<Plug>(YankyGPutAfter)";
          desc = "Put Text After Selection";
        }
        {
          key = "gP";
          mode = [
            "n"
            "x"
          ];
          action = "<Plug>(YankyGPutBefore)";
          desc = "Put Text Before Selection";
        }
        {
          key = "[y";
          mode = "n";
          action = "<Plug>(YankyCycleForward)";
          desc = "Cycle Forward Through Yank History";
        }
        {
          key = "]y";
          mode = "n";
          action = "<Plug>(YankyCycleBackward)";
          desc = "Cycle Backward Through Yank History";
        }
        {
          key = "]p";
          mode = "n";
          action = "<Plug>(YankyPutIndentAfterLinewise)";
          desc = "Put Indented After Cursor (Linewise)";
        }
        {
          key = "[p";
          mode = "n";
          action = "<Plug>(YankyPutIndentBeforeLinewise)";
          desc = "Put Indented Before Cursor (Linewise)";
        }
        {
          key = "]P";
          mode = "n";
          action = "<Plug>(YankyPutIndentAfterLinewise)";
          desc = "Put Indented After Cursor (Linewise)";
        }
        {
          key = "[P";
          mode = "n";
          action = "<Plug>(YankyPutIndentBeforeLinewise)";
          desc = "Put Indented Before Cursor (Linewise)";
        }
        {
          key = ">p";
          mode = "n";
          action = "<Plug>(YankyPutIndentAfterShiftRight)";
          desc = "Put and Indent Right";
        }
        {
          key = "<p";
          mode = "n";
          action = "<Plug>(YankyPutIndentAfterShiftLeft)";
          desc = "Put and Indent Left";
        }
        {
          key = ">P";
          mode = "n";
          action = "<Plug>(YankyPutIndentBeforeShiftRight)";
          desc = "Put Before and Indent Right";
        }
        {
          key = "<P";
          mode = "n";
          action = "<Plug>(YankyPutIndentBeforeShiftLeft)";
          desc = "Put Before and Indent Left";
        }
        {
          key = "=p";
          mode = "n";
          action = "<Plug>(YankyPutAfterFilter)";
          desc = "Put After Applying a Filter";
        }
        {
          key = "=P";
          mode = "n";
          action = "<Plug>(YankyPutBeforeFilter)";
          desc = "Put Before Applying a Filter";
        }
      ];
    };
  };
  programs.nvf.settings.vim.utility = {
    direnv = {
      enable = false;
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
    surround = {
      enable = true;
    };
    undotree = {
      enable = true;
    };
  };
}
