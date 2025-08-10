{ ... }:
{
  programs.nvf.settings.vim = {
    options = {
      autoindent = true;
      shiftwidth = 2;
      tabstop = 2;
      termguicolors = true;
    };
    preventJunkFiles = true;
    searchCase = "smart";
    syntaxHighlighting = true;
    undoFile = {
      enable = true;
    };
  };
}
