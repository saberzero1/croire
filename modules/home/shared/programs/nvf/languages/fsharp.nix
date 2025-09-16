{
  programs.nvf.settings.vim.languages.fsharp = {
    enable = true;
    format = {
      enable = true;
      type = "fantomas";
    };
    lsp = {
      enable = true;
      server = "fsautocomplete";
    };
    treesitter = {
      enable = true;
    };
  };
}
