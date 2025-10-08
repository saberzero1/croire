{
  programs.nvf.settings.vim.languages.nu = {
    enable = true;
    lsp = {
      enable = true;
      servers = "nushell";
    };
    treesitter = {
      enable = true;
    };
  };
}
