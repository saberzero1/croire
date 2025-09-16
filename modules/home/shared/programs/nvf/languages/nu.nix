{
  programs.nvf.settings.vim.languages.nu = {
    enable = true;
    lsp = {
      enable = true;
      server = "nushell";
    };
    treesitter = {
      enable = true;
    };
  };
}
