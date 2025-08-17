{ pkgs, ... }:
{
  programs.nvf.settings.vim = {
    languages.python = {
      enable = true;
      dap = {
        enable = true;
        package =
          with pkgs;
          python313.withPackages (
            ps: with ps; [
              debugpy
            ]
          );
        debugger = "debugpy";
      };
      format = {
        enable = true;
        package = pkgs.black;
        type = "black";
      };
      lsp = {
        enable = true;
        package = pkgs.basedpyright;
        server = "basedpyright";
      };
      treesitter = {
        enable = true;
      };
    };
  };
}
