{ pkgs, ... }:
{
  programs.nvf.settings.vim.lazy.plugins."${pkgs.vimPlugins.hydra-nvim.pname}" = {
    enabled = true;
    event = [ "DeferredUIEnter" ];
    package = pkgs.vimPlugins.hydra-nvim;
    setupOpts = { };
    keys = [
      {
        mode = "n";
        key = "<leader><leader>";
        action = null;
        desc = "Hydra";
      }
    ];
    after = ''
      local Hydra = require("hydra")
      Hydra.setup({
        color = "pink",
        foreign_keys = nil,
        invoke_on_body = true,
        timeout = false,
        -- exit = false,
        on_enter = function()
          require("lualine").refresh()
        end,
        on_exit = function()
          require("lualine").refresh()
        end,
      })
      local buffer_hydra = Hydra({
        name = "BUFFER",
        mode = "n",
        body = "<leader><leader>b",
        hint = [[ Buffer ]],
        config = {},
        heads = {
          { "d", "<cmd>bdelete<CR>", { desc = "Delete", nowait = true }},
          { "h", "<cmd>BufferLineCyclePrev<CR>", { desc = "Next", nowait = true } },
          { "l", "<cmd>BufferLineCycleNext<CR>", { desc = "Previous", nowait = true } },
          { "<Esc>", nil, { exit = true, desc = "Exit", nowait = true } },
        },
      })
      --[===[
      local motion_hydra = Hydra({
        name = "MOTION",
        mode = "n",
        body = "<leader><leader>m",
        hint = [[ Motion ]],
        config = {},
        heads = {
          { "h", "<cmd>HopChar1<CR>", { desc = "Hop Char 1", nowait = true } },
          { "l", "<cmd>HopLine<CR>", { desc = "Hop Line", nowait = true } },
          { "w", "<cmd>HopWord<CR>", { desc = "Hop Word", nowait = true } },
          { "<Esc>", nil, { exit = true, desc = "Exit", nowait = true } },
        },
      })
      --]===]
    '';
  };
}
