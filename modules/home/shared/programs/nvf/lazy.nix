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
        ];
      };
      "${plugin.vim-repeat.pname}" = {
        enabled = true;
        package = plugin.vim-repeat;
      };
    };
  };
}
