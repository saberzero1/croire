{
  programs.nvf.settings.vim.languages.csharp = {
    enable = true;
    lsp = {
      enable = true;
      servers = "omnisharp";
    };
    treesitter = {
      enable = true;
    };
  };
}
