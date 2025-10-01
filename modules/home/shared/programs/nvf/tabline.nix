{ lib, ... }:
let
  lua = lib.mkLuaInline;
in
{
  programs.nvf.settings.vim = {
    tabline = {
      nvimBufferline = {
        enable = true;
        mappings = {
          closeCurrent = null;
          cycleNext = null;
          cyclePrevious = null;
          pick = null;
          sortByExtension = null;
          sortByDirectory = null;
          sortById = null;
          moveNext = null;
          movePrevious = null;
        };
        setupOpts = {
          options = {
            close_command = lua ''
              function(bufnr)
                require("snacks").bufdelete(bufnr)
              end
            '';
            right_mouse_command = lua ''
              function(bufnr)
                require("snacks").bufdelete(bufnr)
              end
            '';
            diagnostics = "nvim_lsp";
            always_show_bufferline = false;
            move_wraps_at_ends = true;
            sort_by = lua ''
              function(a, b)
                local buf_a = a.ordinal or 0
                local buf_b = b.ordinal or 0
                return buf_a < buf_b
              end
            '';
            diagnostics_indicator = lua ''
              function(_, _, diag)
                local icons = {
                  Error = " ";
                  Warning = " ";
                  Info = " ";
                  Hint = " ";
                }
                local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                  .. (diag.warning and icons.Warning .. diag.warning or "")
                return vim.trim(ret)
              end
            '';
            offsets = [
              {
                filetype = "NvimTree";
                highlight = "Directory";
                separator = true;
                text = "File Explorer";
              }
              {
                filetype = "neo-tree";
                highlight = "Directory";
                separator = true;
                text = "File Explorer";
              }
              {
                filetype = "snacks_layout_box";
                highlight = "Directory";
                separator = true;
                text = "File Explorer";
              }
            ];
            numbers = "ordinal";
          };
        };
      };
    };
    binds.whichKey.register = {
      # Handled by hydra.nvim
      "<leader>b" = "+Buffer";
      "<leader>s" = "+Search";
      "<leader>sn" = "+noice";
      "<leader>bm" = null;
      "<leader>bs" = null;
      "<leader>bsi" = null;
    };
  };
}
