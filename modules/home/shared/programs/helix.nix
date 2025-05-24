{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    package = pkgs.evil-helix;
    settings = {
      theme = "tokyonight";
      editor = {
        lineNumbers = "relative";
        lsp.display-messages = true;
      };
      lsp = {
        enable = true;
      };
      keys = {
        normal = {
          space.space = "file_picker";
        };
      };
    };
  };
}
