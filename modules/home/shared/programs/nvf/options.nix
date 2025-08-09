{ ... }:
{
  programs.nvf.settings.vim = {
    options = {
      autoindent = true;
    };
    preventJunkFiles = true;
    searchCase = "smart";
    syntaxHighlighting = true;
  };
}
