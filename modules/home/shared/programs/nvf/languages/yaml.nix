{
  programs.nvf.settings.vim.languages.yaml = {
    enable = true;
    lsp = {
      enable = true;
      servers = "yaml-language-server";
    };
    treesitter = {
      enable = true;
    };
  };
}
