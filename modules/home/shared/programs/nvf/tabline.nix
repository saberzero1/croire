{ ... }:
{
  programs.nvf.settings.vim = {
    tabline = {
      nvimBufferline = {
        enable = true;
        mappings = {
          # Handled by hydra.nvim
          closeCurrent = null;
          cycleNext = null;
          cyclePrevious = null;
          pick = null;
          sortByExtension = null;
          sortByDirectory = null;
          sortById = null;
          moveNext = null;
          movePrevious = null;
        };
      };
    };
    binds.whichKey.register = {
      # Handled by hydra.nvim
      "<leader>b" = "+Buffer";
      "<leader>bm" = null;
      "<leader>bs" = null;
      "<leader>bsi" = null;
    };
  };
}
