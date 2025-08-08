{ ... }:
{
  programs.nvf.settings.vim.utility.yazi-nvim = {
    enable = true;
    mappings = {
      openYazi = "<leader>e";
      openYaziDir = "<leader>E";
    };
    setupOpts = {
      open_for_directories = true;
    };
  };
}
