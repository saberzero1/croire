{
  programs.nvf.settings.vim.languages.go = {
    enable = true;
    dap = {
      enable = true;
      debugger = "delve";
    };
    format = {
      enable = true;
      type = "gofmt";
    };
    lsp = {
      enable = true;
      servers = "gopls";
    };
    treesitter = {
      enable = true;
    };
  };
}
