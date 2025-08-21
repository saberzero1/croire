{ pkgs, ... }:
{
  programs.nvf.settings.vim.lazy.plugins."${pkgs.vimPlugins.hydra-nvim.pname}" = {
    enabled = true;
    event = [ "DeferredUIEnter" ];
    package = pkgs.vimPlugins.hydra-nvim;
    setupOpts = { };
    keys = [ ];
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
        body = "<leader>b",
        hint = [[ Buffer ]],
        config = {},
        heads = {
          { "d", "<cmd>bdelete<CR>", { desc = "Close buffer", nowait = true }},
          { "h", "<cmd>BufferLineCyclePrev<CR>", { desc = "Next buffer", nowait = true } },
          { "l", "<cmd>BufferLineCycleNext<CR>", { desc = "Previous buffer", nowait = true } },
          { "H", "<cmd>BufferLineMovePrev<CR>", { desc = "Move buffer left", nowait = true } },
          { "L", "<cmd>BufferLineMoveNext<CR>", { desc = "Move buffer right", nowait = true } },
          --{ "p", "<cmd>BufferLinePick<CR>", { desc = "Pick buffer", nowait = true } },
          --{ "P", "<cmd>BufferLineSortByExtension<CR>", { desc = "Sort by extension", nowait = true } },
          --{ "D", "<cmd>BufferLineSortByDirectory<CR>", { desc = "Sort by directory", nowait = true } },
          --{ "I", "<cmd>BufferLineSortById<CR>", { desc = "Sort by id", nowait = true } },
          { "<Esc>", nil, { exit = true, desc = "Exit", nowait = true } },
        },
      })
      --[===[
      git_hydra = Hydra({
        name = "GIT",
        mode = "n",
        body = "<leader>g",
        hint = [[ Git ]],
        config = {},
        heads = {
          { "a", "<cmd>Git add %<CR>", { desc = "Git add current file", nowait = true } },
          { "A", "<cmd>Git add .<CR>", { desc = "Git add all files", nowait = true } },
          { "b", "<cmd>Git blame<CR>", { desc = "Git blame", nowait = true } },
          { "B", "<cmd>Git blame --reverse<CR>", { desc = "Git blame reverse", nowait = true } },
          { "c", "<cmd>Git commit<CR>", { desc = "Git commit", nowait = true } },
          { "C", "<cmd>Git commit --amend<CR>", { desc = "Git commit amend", nowait = true } },
          { "d", "<cmd>Git difftool<CR>", { desc = "Git difftool", nowait = true } },
          { "D", "<cmd>Git diff<CR>", { desc = "Git diff", nowait = true } },
          { "f", "<cmd>Git fetch<CR>", { desc = "Git fetch", nowait = true } },
          { "F", "<cmd>Git fetch --all<CR>", { desc = "Git fetch all", nowait = true } },
          { "m", "<cmd>Git mergetool<CR>", { desc = "Git mergetool", nowait = true } },
          { "M", "<cmd>Git merge<CR>", { desc = "Git merge", nowait = true } },
          { "P", "<cmd>Git push<CR>", { desc = "Git push", nowait = true } },
          { "p", "<cmd>Git pull<CR>", { desc = "Git pull", nowait = true } },
          { "s", "<cmd>Git status<CR>", { desc = "Git status", nowait = true } },
          { "<Esc>", nil, { exit = true, desc = "Exit", nowait = true } },
        },
      })
      --]===]
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
