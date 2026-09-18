{
  programs.nvf.settings.vim.notes.todo-comments = {
    enable = true;
    # nvf's defaults put todo pickers under <leader>td*, which has no which-key
    # group here and duplicated the <leader>s*/<leader>x* keys below. (Its
    # <leader>tdt "Trouble" binding is gated on vim.lsp.trouble.enable, which is
    # off now that diagnostics.nix owns Trouble, so it drops out on its own.)
    mappings = {
      quickFix = null;
      telescope = null;
      trouble = null;
    };
  };

  # Todo navigation + Trouble views. These lived in coding.nix attached to the
  # ts-comments plugin, which is a different plugin -- they belong here with
  # todo-comments. The pickers (<leader>st / <leader>sT) are in filetree.nix
  # alongside the other Telescope keys.
  programs.nvf.settings.vim.keymaps = [
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
  ];
}
