{ pkgs, ... }:
# TODO: fix supertab bindings
{
  programs.nvf.settings.vim.autocomplete = {
    enableSharedCmpSources = true;
    blink-cmp = {
      enable = true;
      friendly-snippets = {
        enable = true;
      };
      mappings = {
        /*
          confirm = "<CR>";
          complete = "<S-Space>";
          next = "<C-n>";
          previous = "<C-p>";
        */
        close = null;
        complete = null;
        confirm = null;
        next = null;
        previous = null;
        scrollDocsDown = null;
        scrollDocsUp = null;
      };
      sourcePlugins = {
        "blink-cmp-copilot" = {
          enable = true;
          package = pkgs.vimPlugins.blink-cmp-copilot;
          module = "blink-cmp-copilot";
        };
      };
      setupOpts = {
        completion = {
          accept = {
            auto_brackets = {
              enabled = true;
            };
          };
          menu = {
            #auto_show = true;
            draw = {
              treesitter = [ "lsp" ];
            };
          };
          documentation = {
            auto_show = true;
            auto_show_delay_ms = 200;
          };
          ghost_text = {
            enabled = true;
          };
        };
        sources = {
          default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];
          providers = {
            copilot = {
              name = "copilot";
              module = "blink-cmp-copilot";
              kind = "Copilot";
              score_offset = 100;
              async = true;
            };
          };
        };
        snippets = {
          preset = "luasnip";
        };
      };
    };
  };
}
