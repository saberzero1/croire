{ pkgs, ... }:
let
  plugin = pkgs.vimPlugins;
in
{
  programs.nvf.settings.vim.lazy.plugins = {
    # ts-comments fixes `commentstring` per language so Neovim 0.10+'s built-in
    # gc/gcc comment the right way in mixed-language files. It was previously
    # lazy-loaded on `cmd = ["TodoTrouble" "TodoTelescope"]` with keys that
    # called require("todo-comments") -- a different plugin entirely -- so
    # commentstring fixes only kicked in after running a Todo command. Loading
    # on BufReadPost/BufNewFile is what it actually wants.
    #
    # Comment.nvim was dropped alongside this: Neovim 0.12 has native gc/gcc,
    # and ts-comments is designed to enhance exactly that.
    "${plugin.ts-comments-nvim.pname}" = {
      enabled = true;
      lazy = true;
      package = plugin.ts-comments-nvim;
      event = [
        "BufReadPost"
        "BufNewFile"
      ];
      setupModule = "ts-comments";
      setupOpts = { };
    };
    "mini-surround" = {
      enabled = true;
      lazy = true;
      package = "mini-surround";
      setupModule = "mini.surround";
      keys = [
        {
          key = "gsa";
          mode = [
            "n"
            "v"
          ];
          desc = "Add surrounding";
        }
        {
          key = "gsd";
          mode = [
            "n"
            "v"
          ];
          desc = "Delete surrounding";
        }
        {
          key = "gsf";
          mode = "n";
          desc = "Find right surrounding";
        }
        {
          key = "gsF";
          mode = "n";
          desc = "Find left surrounding";
        }
        {
          key = "gsh";
          mode = "n";
          desc = "Highlight surrounding";
        }
        {
          key = "gsr";
          mode = [
            "n"
            "v"
          ];
          desc = "Replace surrounding";
        }
        {
          key = "gsn";
          mode = "n";
          desc = "Update `n_lines`";
        }
      ];
      setupOpts = {
        mappings = {
          add = "gsa"; # Add surrounding in Normal and Visual modes
          delete = "gsd"; # Delete surrounding
          find = "gsf"; # Find surrounding (to the right)
          find_left = "gsF"; # Find surrounding (to the left)
          highlight = "gsh"; # Highlight surrounding
          replace = "gsr"; # Replace surrounding
          update_n_lines = "gsn"; # Update `n_lines`
        };
      };
    };
  };
}
