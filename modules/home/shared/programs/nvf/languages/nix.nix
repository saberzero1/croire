{ pkgs, ... }:
{
  programs.nvf.settings.vim = {
    languages.nix = {
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
        servers = [ "nixd" ];
      };
      treesitter = {
        enable = true;
      };
    };
  };
}
