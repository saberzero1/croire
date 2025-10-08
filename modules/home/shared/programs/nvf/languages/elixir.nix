{
  programs.nvf.settings.vim.languages.elixir = {
    enable = true;
    elixir-tools = {
      enable = true;
    };
    format = {
      enable = true;
      type = "mix";
    };
    lsp = {
      enable = true;
      servers = "elixirls";
    };
    treesitter = {
      enable = true;
    };
  };
}
