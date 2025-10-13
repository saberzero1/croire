{
  programs.lazyvim.plugins.colorscheme = ''
    return {
      "folke/tokyonight.nvim",
      lazy = true,
      opts = {
        style = "storm",
      },
    }
  '';
}
