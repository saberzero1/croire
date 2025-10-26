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
      servers = "svelte";
    };
    treesitter = {
      enable = true;
    };
  };
}
