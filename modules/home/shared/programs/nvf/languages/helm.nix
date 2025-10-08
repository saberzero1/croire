{
  programs.nvf.settings.vim.languages.helm = {
    enable = true;
    lsp = {
      enable = true;
      servers = "helm-ls";
    };
    treesitter = {
      enable = true;
    };
  };
}
