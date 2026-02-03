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
  };
}
