{ pkgs, ... }:
let
  plugin = pkgs.vimPlugins;
in
{
  programs.nvf.settings.vim = {
    diagnostics = {
      enable = true;
      nvim-lint = {
        enable = true;
        lint_after_save = true;
      };
    };
    lazy.plugins = {
      "${plugin.trouble-nvim.pname}" = {
        enabled = true;
        package = plugin.trouble-nvim;
        cmd = "Trouble";
        setupOpts = {
          modes = {
            lsp = {
              win = {
                position = "right";
              };
            };
          };
        };
        keys = [
          {
            key = "<leader>xx";
            mode = "n";
            action = "<cmd>Trouble diagnostics toggle<cr>";
            desc = "Diagnostics (Trouble)";
          }
          {
            key = "<leader>xX";
            mode = "n";
            action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
            desc = "Buffer Diagnostics (Trouble)";
          }
          {
            key = "<leader>cs";
            mode = "n";
            action = "<cmd>Trouble symbols toggle<cr>";
            desc = "Symbols (Trouble)";
          }
          {
            key = "<leader>cS";
            mode = "n";
            action = "<cmd>Trouble lsp toggle<cr>";
            desc = "LSP references/definitions/... (Trouble)";
          }
          {
            key = "<leader>xL";
            mode = "n";
            action = "<cmd>Trouble loclist toggle<cr>";
            desc = "Location List (Trouble)";
          }
          {
            key = "<leader>xQ";
            mode = "n";
            action = "<cmd>Trouble qflist toggle<cr>";
            desc = "Quickfix List (Trouble)";
          }
          {
            key = "[q";
            mode = "n";
            action = ''
              function()
                if require("trouble").is_open() then
                  require("trouble").prev({ skip_groups = true, jump = true })
                else
                  local ok, err = pcall(vim.cmd.cprev)
                  if not ok then
                    vim.notify(err, vim.log.levels.ERROR)
                  end
                end
              end
            '';
            lua = true;
            desc = "Previous Trouble/Quickfix Item";
          }
          {
            key = "]q";
            mode = "n";
            action = ''
              function()
                if require("trouble").is_open() then
                  require("trouble").next({ skip_groups = true, jump = true })
                else
                  local ok, err = pcall(vim.cmd.cnext)
                  if not ok then
                    vim.notify(err, vim.log.levels.ERROR)
                  end
                end
              end
            '';
            lua = true;
            desc = "Next Trouble/Quickfix Item";
          }
        ];
      };
    };
  };
}
