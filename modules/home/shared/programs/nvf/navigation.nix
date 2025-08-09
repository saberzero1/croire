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
        enable = true;
      };
    };
    telescope = {
      enable = true;
      extensions = [ ];
    };
  };
}
