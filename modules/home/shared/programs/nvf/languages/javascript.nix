{ pkgs, ... }:
{
  programs.nvf.settings.vim = {
    languages = {
      css = {
        enable = true;
        format = {
          enable = true;
          package = pkgs.nodePackages.prettier;
          type = "prettier";
        };
        lsp = {
          enable = true;
          server = "vscode-langservers-extracted";
        };
        treesitter = {
          enable = true;
        };
      };
      html = {
        enable = true;
        treesitter = {
          enable = true;
        };
      };
      svelte = {
        enable = true;
        extraDiagnostics = {
          enable = true;
          types = [ "eslint_d" ];
        };
        format = {
          enable = true;
          type = "prettier";
        };
        lsp = {
          enable = true;
          server = "svelte";
        };
        treesitter = {
          enable = true;
        };
      };
      ts = {
        enable = true;
        extraDiagnostics = {
          enable = true;
          types = [ "eslint_d" ];
        };
        format = {
          enable = true;
          package = pkgs.nodePackages.prettier;
          type = "prettier";
        };
        lsp = {
          enable = true;
          server = "ts_ls";
        };
        treesitter = {
          enable = true;
        };
      };
    };
  };
}
