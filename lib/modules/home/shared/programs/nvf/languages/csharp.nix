{ pkgs, ... }:
{
  # omnisharp depends on dotnet which is broken on Darwin (nixpkgs #450126)
  programs.nvf.settings.vim.languages.csharp = {
    enable = true;
    lsp = {
      enable = !pkgs.stdenv.hostPlatform.isDarwin;
      servers = [ "omnisharp" ];
    };
    treesitter = {
      enable = true;
    };
  };
}
