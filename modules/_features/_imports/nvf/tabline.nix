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
            # NvimTree was never installed and neo-tree has been dropped, so
            # only the snacks layout box remains.
            offsets = [
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
    # nvf's bufferline module registers <leader>bm / <leader>bs / <leader>bsi
    # which-key groups for its Move/Sort mappings. Those mappings are nulled
    # above, so without these the groups would show as labels for keys that
    # don't exist. The <leader>b and <leader>s groups themselves are declared
    # once in binds.nix.
    binds.whichKey.register = {
      "<leader>bm" = null;
      "<leader>bs" = null;
      "<leader>bsi" = null;
    };
  };
}
