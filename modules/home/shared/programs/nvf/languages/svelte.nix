{
  programs.nvf.settings.vim.languages.svelte = {
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
      server = "svelte";
    };
    treesitter = {
      enable = true;
    };
  };
}
