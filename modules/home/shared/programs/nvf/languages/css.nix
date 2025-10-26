{
  programs.nvf.settings.vim.languages.css = {
    enable = true;
    format = {
      enable = true;
      type = "prettier";
    };
    lsp = {
      enable = true;
      servers = "cssls";
    };
  };
}
