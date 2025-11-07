{
  programs.nvf.settings.vim.languages.typst = {
    enable = true;
    format = {
      enable = true;
      type = "typstyle";
    };
    lsp = {
      enable = true;
      servers = "tinymist";
    };
    treesitter = {
      enable = true;
    };
  };
}
