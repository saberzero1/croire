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
    breadcrumbs = {
      enable = true;
      navbuddy = {
        enable = true;
      };
    };
    colorizer = {
      enable = true;
    };
    fastaction = {
      enable = true;
    };
    illuminate = {
      enable = true;
    };
    noice = {
      enable = true;
    };
    smartcolumn = {
      enable = true;
      setupOpts = {
        colorcolumn = "80";
        disabled_filetypes = [
          "help"
          "text"
          "markdown"
          "NvimTree"
          "alpha"
          "dashboard"
          "ministarter"
          "snacks_dashboard"
          "startify"
        ];
      };
    };
  };
}
