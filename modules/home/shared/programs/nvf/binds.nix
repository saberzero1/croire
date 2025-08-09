{ ... }:
{
  programs.nvf.settings.vim = {
    binds = {
      cheatsheet = {
        enable = true;
      };
      whichKey = {
        enable = true;
      };
    };
    ui.borders.plugins.which-key = {
      enable = true;
      style = "rounded";
    };
  };
}
