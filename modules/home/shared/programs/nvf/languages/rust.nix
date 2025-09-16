{
  programs.nvf.settings.vim.languages.rust = {
    enable = true;
    crates = {
      enable = true;
      codeActions = true;
    };
    dap = {
      enable = true;
    };
    format = {
      enable = true;
      type = "rustfmt";
    };
    lsp = {
      enable = true;
      opts = ''
        ['rust-analyzer'] = {
          cargo = {allFeature = true},
          checkOnSave = true,
          procMacro = {
            enable = true,
          },
        },
      '';
    };
    treesitter = {
      enable = true;
    };
  };
}
