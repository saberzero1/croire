{ ... }:
{
  programs.nvf.settings.vim = {
    options = {
      autoindent = true;
      cmdheight = 0;
      laststatus = 3;
      shiftwidth = 2;
      tabstop = 2;
      termguicolors = true;
      tm = 300;
      updatetime = 100;
      wrap = false;
    };
    preventJunkFiles = true;
    searchCase = "smart";
    syntaxHighlighting = true;
    undoFile = {
      enable = true;
    };
  };
}
