{ pkgs, ... }:
{
  programs.nvf.settings.vim = {
    extraPackages = with pkgs; [
      fzf
      lazygit
      ripgrep
      # vimPlugins.nvim-treesitter.allGrammars
    ];
  };
}
