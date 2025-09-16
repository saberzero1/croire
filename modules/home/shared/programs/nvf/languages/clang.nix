{
  programs.nvf.settings.vim.languages.clang = {
    enable = true;
    cHeader = true;
    dap = {
      enable = true;
      debugger = "lldb-vscode";
    };
    lsp = {
      enable = true;
      opts = null;
      server = "clangd";
    };
    treesitter = {
      enable = true;
    };
  };
}
