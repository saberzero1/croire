{ ... }:
{
  programs.nvf.settings.vim.diagnostics = {
    enable = true;
    nvim-lint = {
      enable = true;
      lint_after_save = true;
    };
  };
}
