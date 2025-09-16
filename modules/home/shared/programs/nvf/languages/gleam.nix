{
  programs.nvf.settings.vim.languages.gleam = {
    enable = true;
    lsp = {
      enable = true;
      server = "gleam";
    };
    treesitter = {
      enable = true;
    };
  };
}
