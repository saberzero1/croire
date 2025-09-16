{
  programs.nvf.settings.vim.languages.typst = {
    enable = true;
    format = {
      enable = true;
      type = "typstfmt";
    };
    lsp = {
      enable = true;
      server = "tinymist";
    };
    treesitter = {
      enable = true;
    };
  };
}
