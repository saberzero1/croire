{
  programs.nvf.settings.vim.languages.astro = {
    enable = false;
    extraDiagnostics = {
      enable = true;
      types = [ "eslint_d" ];
    };
    format = {
      enable = true;
      type = [ "prettier" ];
    };
    lsp = {
      enable = true;
      servers = [ "astro" ];
    };
    treesitter = {
      enable = true;
    };
  };
}
