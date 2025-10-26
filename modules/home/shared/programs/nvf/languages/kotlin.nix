{
  programs.nvf.settings.vim.languages.kotlin = {
    enable = true;
    extraDiagnostics = {
      enable = true;
      types = [ "ktlint" ];
    };
    lsp = {
      enable = true;
    };
    treesitter = {
      enable = true;
    };
  };
}
