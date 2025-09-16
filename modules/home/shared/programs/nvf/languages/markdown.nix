{
  programs.nvf.settings.vim.languages.markdown = {
    enable = true;
    extraDiagnostics = {
      enable = true;
      types = [ "markdownlint-cli2" ];
    };
    format = {
      enable = true;
      extraFiletypes = [ "mdx" ];
      type = "prettierd";
    };
    lsp = {
      enable = true;
      server = "marksman";
    };
    treesitter = {
      enable = true;
    };
  };
}
