{
  programs.nvf.settings.vim.languages.ocaml = {
    enable = true;
    format = {
      enable = true;
      type = "ocamlformat";
    };
    lsp = {
      enable = true;
      server = "ocaml-lsp";
    };
    treesitter = {
      enable = true;
    };
  };
}
