{
  programs.nvf.settings.vim.languages.astro = {
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
      server = "astro";
    };
    treesitter = {
      enable = true;
    };
  };
}
