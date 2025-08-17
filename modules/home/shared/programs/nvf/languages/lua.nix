{ pkgs, ... }:
{
  programs.nvf.settings.vim = {
    languages.lua = {
      enable = true;
      extraDiagnostics = {
        enable = true;
        types = [ "luacheck" ];
      };
      format = {
        enable = true;
        package = pkgs.stylua;
        type = "stylua";
      };
      lsp = {
        enable = true;
        package = pkgs.lua-language-server;
      };
      treesitter = {
        enable = true;
      };
    };
  };
}
