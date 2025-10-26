{
  programs.nvf.settings.vim.languages.vala = {
    enable = true;
    lsp = {
      enable = true;
      servers = "vala_ls";
    };
    treesitter = {
      enable = true;
    };
  };
}
