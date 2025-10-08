{
  programs.nvf.settings.vim.languages.fsharp = {
    enable = true;
    format = {
      enable = true;
      type = "fantomas";
    };
    lsp = {
      enable = true;
      servers = "fsautocomplete";
    };
    treesitter = {
      enable = true;
    };
  };
}
