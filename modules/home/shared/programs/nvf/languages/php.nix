{
  programs.nvf.settings.vim.languages.php = {
    enable = true;
    lsp = {
      enable = true;
      servers = "phpactor";
    };
    treesitter = {
      enable = true;
    };
  };
}
