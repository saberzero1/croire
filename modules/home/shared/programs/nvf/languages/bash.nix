{
  programs.nvf.settings.vim.languages.bash = {
    enable = true;
    extraDiagnostics = {
      enable = true;
      types = [ "shellcheck" ];
    };
    format = {
      enable = true;
      type = "shfmt";
    };
    lsp = {
      enable = true;
      servers = "bash-ls";
    };
    treesitter = {
      enable = true;
    };
  };
}
