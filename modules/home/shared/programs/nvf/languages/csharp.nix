{
  programs.nvf.settings.vim.languages.csharp = {
    enable = true;
    lsp = {
      enable = true;
      server = "omnisharp";
    };
    treesitter = {
      enable = true;
    };
  };
}
