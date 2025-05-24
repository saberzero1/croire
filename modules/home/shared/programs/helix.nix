{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    package = pkgs.evil-helix;
    settings = {
      theme = "tokyonight";
      editor = {
        auto-format = true;
        color-modes = true;
        evil = true;
        insert-final-newline = true;
        line-number = "relative";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        inline-diagnostics = {
          cursor-line = "hint";
        };
        lsp = {
          enable = true;
          display-messages = true;
        };
      };
      keys = {
        normal = {
          space = {
            space = "file_picker";
            s.g = "global_search";
          };
        };
      };
    };
  };
}
