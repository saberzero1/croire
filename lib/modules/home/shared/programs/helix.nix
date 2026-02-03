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
          "{" = "goto_prev_paragraph";
          "}" = "goto_next_paragraph";
          C-j = [
            "extend_to_line_bounds"
            "delete_selection"
            "paste_after"
          ];
          C-k = [
            "extend_to_line_bounds"
            "delete_selection"
            "move_line_up"
            "paste_before"
          ];
        };
      };
    };
  };
}
