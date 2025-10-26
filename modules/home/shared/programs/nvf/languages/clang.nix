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
      servers = "clangd";
    };
    treesitter = {
      enable = true;
    };
  };
}
