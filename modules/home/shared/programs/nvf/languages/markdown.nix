{ pkgs, ... }:
{
  # marksman depends on dotnet which is broken on Darwin (nixpkgs #450126)
  programs.nvf.settings.vim.languages.markdown = {
    enable = true;
    extraDiagnostics = {
      enable = true;
      types = [ "markdownlint-cli2" ];
    };
    format = {
      enable = true;
      extraFiletypes = [ "mdx" ];
      type = [ "prettierd" ];
    };
    lsp = {
      enable = !pkgs.stdenv.hostPlatform.isDarwin;
      servers = [ "marksman" ];
    };
    treesitter = {
      enable = true;
    };
  };
}
