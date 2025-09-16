{
  programs.nvf.settings.vim.languages.lua = {
    enable = true;
    extraDiagnostics = {
      enable = true;
      types = [ "luacheck" ];
    };
    format = {
      enable = true;
      type = "stylua";
    };
    lsp = {
      enable = true;
    };
    treesitter = {
      enable = true;
    };
  };
}
