{
  programs.nvf.settings.vim.languages.wgsl = {
    enable = true;
    lsp = {
      enable = true;
      servers = "wgsl-analyzer";
    };
    treesitter = {
      enable = true;
    };
  };
}
