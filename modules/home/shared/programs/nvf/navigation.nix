{ ... }:
{
  programs.nvf.settings.vim = {
    navigation = {
      harpoon = {
        enable = true;
      };
    };
    minimap = {
      minimap-vim = {
        enable = false;
      };
      codewindow = {
        enable = true;
      };
    };
    utility.snacks-nvim.setupOpts.picker = {
      enable = true;
      ui_select = true;
    };
    telescope = {
      enable = true;
    };
  };
}
