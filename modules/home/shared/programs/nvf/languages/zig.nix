{
  programs.nvf.settings.vim.languages.zig = {
    enable = true;
    dap = {
      enable = true;
      debugger = "lldb-vscode";
    };
    lsp = {
      enable = true;
      servers = "zls";
    };
    treesitter = {
      enable = true;
    };
  };
}
