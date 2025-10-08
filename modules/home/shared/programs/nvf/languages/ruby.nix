{
  programs.nvf.settings.vim.languages.ruby = {
    enable = true;
    extraDiagnostics = {
      enable = true;
      types = [ "rubocop" ];
    };
    format = {
      enable = true;
      type = "rubocop";
    };
    lsp = {
      enable = false;
    };
    treesitter = {
      enable = true;
    };
  };
}
