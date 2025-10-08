{
  programs.nvf.settings.vim.languages.r = {
    enable = true;
    format = {
      enable = true;
      type = "format_r";
    };
    lsp = {
      enable = true;
      servers = "r_language_server";
    };
    treesitter = {
      enable = true;
    };
  };
}
