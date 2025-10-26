{ pkgs, ... }:
let
  plugin = pkgs.vimPlugins;
in
{
  programs.nvf.settings.vim.lazy.plugins = {
    "${plugin.ts-comments-nvim.pname}" = {
      enabled = true;
      lazy = true;
      package = plugin.ts-comments-nvim;
      cmd = [
        "TodoTrouble"
        "TodoTelescope"
      ];
      setupModule = "ts-comments.nvim";
      setupOpts = { };
      keys = [
        {
          key = "]t";
          mode = "n";
          action = ''
            function()
              require("todo-comments").jump_next()
            end
          '';
          lua = true;
          desc = "Next Todo Comment";
        }
        {
          key = "[t";
          mode = "n";
          action = ''
            function()
              require("todo-comments").jump_prev()
            end
          '';
          lua = true;
          desc = "Previous Todo Comment";
        }
        {
          key = "<leader>xt";
          mode = "n";
          action = "<cmd>Trouble todo toggle<cr>";
          desc = "Todo (Trouble)";
        }
        {
          key = "<leader>xT";
          mode = "n";
          action = "<cmd>Trouble todo toggle filter={tag={TODO,FIX,FIXME}}<cr>";
          desc = "Todo/Fix/Fixme (Trouble)";
        }
        {
          key = "<leader>st";
          mode = "n";
          action = "<cmd>TodoTelescope<cr>";
          desc = "Todo";
        }
        {
          key = "<leader>sT";
          mode = "n";
          action = "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>";
          desc = "Todo/Fix/Fixme";
        }
      ];
    };
    "mini-surround" = {
      enabled = true;
      lazy = true;
      package = "mini-surround";
      setupModule = "mini.surround";
      keys = [
        {
          key = "gsa";
          mode = [
            "n"
            "v"
          ];
          desc = "Add surrounding";
        }
        {
          key = "gsd";
          mode = [
            "n"
            "v"
          ];
          desc = "Delete surrounding";
        }
        {
          key = "gsf";
          mode = "n";
          desc = "Find right surrounding";
        }
        {
          key = "gsF";
          mode = "n";
          desc = "Find left surrounding";
        }
        {
          key = "gsh";
          mode = "n";
          desc = "Highlight surrounding";
        }
        {
          key = "gsr";
          mode = [
            "n"
            "v"
          ];
          desc = "Replace surrounding";
        }
        {
          key = "gsn";
          mode = "n";
          desc = "Update `n_lines`";
        }
      ];
      setupOpts = {
        mappings = {
          add = "gsa"; # Add surrounding in Normal and Visual modes
          delete = "gsd"; # Delete surrounding
          find = "gsf"; # Find surrounding (to the right)
          find_left = "gsF"; # Find surrounding (to the left)
          highlight = "gsh"; # Highlight surrounding
          replace = "gsr"; # Replace surrounding
          update_n_lines = "gsn"; # Update `n_lines`
        };
      };
    };
    "yanky-nvim" = {
      enabled = true;
      lazy = true;
      package = "yanky-nvim";
      setupModule = "yanky";
      setupOpts = {
        ring.storage = "shada";
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
}
