{
  programs.nvf.settings.vim.visuals = {
    # fidget-nvim dropped: noice already owns LSP progress and messaging
    # (snacks notifier/notify are disabled for the same reason).
    #
    # indent-blankline stays off: snacks `indent` provides indent guides.
    #
    # nvim-cursorline dropped: vim-illuminate is the single word/reference
    # highlighter (snacks `words` dropped alongside it).
    #
    # nvim-scrollbar dropped: gitsigns hunks and diagnostic signs already
    # surface the same information in the gutter.
    highlight-undo = {
      enable = true;
    };
    rainbow-delimiters = {
      enable = true;
    };
  };
}
