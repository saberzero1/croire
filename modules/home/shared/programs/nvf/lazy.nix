{ pkgs, ... }:
let
  plugin = pkgs.vimPlugins;
in
{
  programs.nvf.settings.vim.lazy = {
    enable = true;
    enableLznAutoRequire = true;
    loader = "lz.n";
    plugins = {
      "${plugin.persistence-nvim.pname}" = {
        enabled = true;
        package = plugin.persistence-nvim;
        event = "BufReadPre";
        setupModule = "persistence";
        keys = [
          {
            key = "<leader>qs";
            mode = "n";
            action = "<cmd>lua require('persistence').load()<cr>";
            desc = "Restore Session";
          }
          {
            key = "<leader>qS";
            mode = "n";
            action = "<cmd>lua require('persistence').select()<cr>";
            desc = "Select Session";
          }
          {
            key = "<leader>ql";
            mode = "n";
            action = "<cmd>lua require('persistence').load({ last = true })<cr>";
            desc = "Restore Last Session";
          }
          {
            key = "<leader>qd";
            mode = "n";
            action = "<cmd>lua require('persistence').stop()<cr>";
            desc = "Don't Save Current Session";
          }
          {
            key = "<leader>qq";
            mode = "n";
            action = "<cmd>qa<cr>";
            desc = "Quit Session";
          }
          {
            key = "<leader>hc";
            mode = "n";
            action = ":checkhealth<cr>";
            desc = "Check Health";
          }
          # Bufferline.nvim
          {
            key = "<leader>bp";
            mode = "n";
            action = "<cmd>BufferLineTogglePin<cr>";
            desc = "Toggle Pin";
          }
          {
            key = "<leader>bP";
            mode = "n";
            action = "<cmd>BufferLineGroupClose ungrouped<cr>";
            desc = "Delete Non-Pinned Buffers";
          }
          {
            key = "<leader>br";
            mode = "n";
            action = "<cmd>BufferLineCloseRight<cr>";
            desc = "Delete Buffers to the Right";
          }
          {
            key = "<leader>bl";
            mode = "n";
            action = "<cmd>BufferLineCloseLeft<cr>";
            desc = "Delete Buffers to the Left";
          }
          {
            key = "<S-h>";
            mode = "n";
            action = "<cmd>BufferLineCyclePrev<cr>";
            desc = "Prev Buffer";
          }
          {
            key = "<S-l>";
            mode = "n";
            action = "<cmd>BufferLineCycleNext<cr>";
            desc = "Next Buffer";
          }
          {
            key = "[b";
            mode = "n";
            action = "<cmd>BufferLineCyclePrev<cr>";
            desc = "Prev Buffer";
          }
          {
            key = "]b";
            mode = "n";
            action = "<cmd>BufferLineCycleNext<cr>";
            desc = "Next Buffer";
          }
          {
            key = "[B";
            mode = "n";
            action = "<cmd>BufferLineMovePrev<cr>";
            desc = "Move Buffer prev";
          }
          {
            key = "]B";
            mode = "n";
            action = "<cmd>BufferLineMoveNext<cr>";
            desc = "Move Buffer next";
          }
        ];
      };
      "${plugin.vim-repeat.pname}" = {
        enabled = true;
        package = plugin.vim-repeat;
      };
    };
  };
}
