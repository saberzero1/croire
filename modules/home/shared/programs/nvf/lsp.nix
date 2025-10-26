{
  programs.nvf.settings.vim.lsp = {
    enable = true;
    formatOnSave = true;
    lightbulb = {
      enable = true;
    };
    lspconfig = {
      enable = true;
      sources = { };
    };
    otter-nvim = {
      enable = true;
      setupOpts = {
        handle_leading_whitespace = true;
        diagnostic_update_event = [
          "BufWritePost"
          "InsertLeave"
          "TextChanged"
        ];
      };
    };
    trouble = {
      enable = true;
    };
    servers = {
      "*" = {
        root_markers = [ ".git" "flake.nix" ];
        capabilities = {
          textDocument = {
            multilineTokenSupport = true;
          };
        };
      };
    };
  };
}
