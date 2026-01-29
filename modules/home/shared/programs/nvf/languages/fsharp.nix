{ pkgs, ... }:
{
  # fsautocomplete and fantomas depend on dotnet which is broken on Darwin (nixpkgs #450126)
  programs.nvf.settings.vim.languages.fsharp = {
    enable = true;
    format = {
      enable = !pkgs.stdenv.hostPlatform.isDarwin;
      type = [ "fantomas" ];
    };
    lsp = {
      enable = !pkgs.stdenv.hostPlatform.isDarwin;
      servers = [ "fsautocomplete" ];
    };
    treesitter = {
      enable = true;
    };
  };
}
