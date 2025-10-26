{
  programs.nvf.settings.vim.languages.haskell = {
    enable = true;
    dap = {
      enable = false; # currently broken
    };
    lsp = {
      enable = true;
    };
    treesitter = {
      enable = true;
    };
  };
}
