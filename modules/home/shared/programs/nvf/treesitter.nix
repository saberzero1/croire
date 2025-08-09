{ pkgs, ... }:
{
  programs.nvf.settings.vim.treesitter = {
    enable = true;
    addDefaultGrammars = true;
    context = {
      enable = true;
    };
    fold = true;
    grammars = with pkgs.vimPlugins.nvim-treesitter; [ withAllGrammars ];
    highlight = {
      enable = true;
    };
    textobjects = {
      enable = true;
    };
  };
}
