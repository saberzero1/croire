{
  programs.nvf.settings.vim.languages.wgsl = {
    enable = true;
    lsp = {
      enable = true;
      server = "wgsl-analyzer";
    };
    treesitter = {
      enable = true;
    };
  };
}
