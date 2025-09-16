{ pkgs, ... }:
{
  programs.nvf.settings.vim.languages.nix = {
    enable = true;
    extraDiagnostics = {
      enable = true;
      types = [
        "deadnix"
        "statix"
      ];
    };
    format = {
      enable = true;
      package = pkgs.nixfmt;
      type = "nixfmt";
    };
    lsp = {
      enable = true;
      options = null;
      package = pkgs.nixd;
      server = "nixd";
    };
    treesitter = {
      enable = true;
    };
  };
}
