{ ... }:
{
  programs.nvf.settings.vim.lsp = {
    enable = true;
    formatOnSave = true;
    lightbulb = {
      enable = true;
    };
    lspconfig = {
      enable = true;
    };
    otter-nvim = {
      enable = true;
    };
    trouble = {
      enable = true;
    };
  };
}
