{
  programs.nvf.settings.vim.languages.python = {
    enable = true;
    dap = {
      enable = true;
      debugger = "debugpy";
    };
    format = {
      enable = true;
      type = "black";
    };
    lsp = {
      enable = true;
      servers = "basedpyright";
    };
    treesitter = {
      enable = true;
    };
  };
}
