{
  programs.nvf.settings.vim.languages.ocaml = {
    enable = true;
    format = {
      enable = true;
      type = "ocamlformat";
    };
    lsp = {
      enable = true;
      servers = "ocaml-lsp";
    };
    treesitter = {
      enable = true;
    };
  };
}
