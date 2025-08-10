{ ... }:
{
  programs.nvf.settings.vim.ui = {
    borders = {
      enable = true;
      globalStyle = "rounded";
      plugins = {
        which-key = {
          enable = true;
        };
      };
    };
    smartcolumn = {
      enable = true;
      setupOpts = {
        colorcolumn = "80";
      };
    };
  };
}
