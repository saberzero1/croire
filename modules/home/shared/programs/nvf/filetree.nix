{ ... }:
{
  programs.nvf.settings.vim = {
    fzf-lua = {
      enable = true;
    };
    filetree.neo-tree = {
      enable = true;
    };
    utility.yazi-nvim = {
      enable = true;
      mappings = {
        openYazi = "<leader>e";
        openYaziDir = "<leader>E";
      };
      setupOpts = {
        open_for_directories = true;
      };
    };
  };
}
