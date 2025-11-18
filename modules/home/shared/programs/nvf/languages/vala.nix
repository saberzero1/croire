{
  programs.nvf.settings.vim.languages.vala = {
    enable = false;
    lsp = {
      enable = true;
      servers = [ "vala_ls" ];
    };
    treesitter = {
      enable = true;
    };
  };
}
