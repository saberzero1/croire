{
  programs.nvf.settings.vim.languages.ts = {
    enable = true;
    extraDiagnostics = {
      enable = true;
      types = [ "eslint_d" ];
    };
    format = {
      enable = true;
      type = "prettier";
    };
    lsp = {
      enable = true;
      server = "ts_ls";
    };
    treesitter = {
      enable = true;
    };
  };
}
