{ ... }:
{
  programs.nvf.settings.vim = {
    tabline = {
      nvimBufferline = {
        enable = true;
        mappings = {
          closeCurrent = "<leader>bd";
          cycleNext = "L";
          cyclePrevious = "H";
          pick = "<leader>bp";
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
      "<leader>s" = "+Search";
      "<leader>bm" = null;
      "<leader>bs" = null;
      "<leader>bsi" = null;
    };
  };
}
