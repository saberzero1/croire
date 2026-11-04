{
  programs.nvf.settings.vim.theme = {
    enable = true;
    name = "tokyonight";
    style = "storm";
    transparent = true;
  };

  # Neovim detects the terminal background (dark by default); re-apply on change
  programs.nvf.settings.vim.luaConfigRC.theme-auto = ''
    vim.api.nvim_create_autocmd("OptionSet", {
      pattern = "background",
      callback = function()
        vim.cmd.colorscheme("tokyonight")
      end,
    })
  '';
}
