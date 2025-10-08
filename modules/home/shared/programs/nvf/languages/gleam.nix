{
  programs.nvf.settings.vim.languages.gleam = {
    enable = true;
    lsp = {
      enable = true;
      servers = "gleam";
    };
    treesitter = {
      enable = true;
    };
  };
}
