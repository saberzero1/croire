{
  programs.nvf.settings.vim.languages.zig = {
    enable = true;
    dap = {
      enable = true;
      debugger = "lldb-vscode";
    };
    lsp = {
      enable = true;
      server = "zls";
    };
    treesitter = {
      enable = true;
    };
  };
}
