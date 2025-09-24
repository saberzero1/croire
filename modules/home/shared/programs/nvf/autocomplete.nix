{ pkgs, lib, ... }:
let
  lua = lib.mkLuaInline;
in
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
        "blink-copilot" = {
          enable = true;
          package = pkgs.vimPlugins.blink-copilot;
          # package = pkgs.vimPlugins.blink-cmp-copilot;
          # module = "blink-cmp-copilot";
          module = "blink-copilot";
        };
        /*
          "blink-cmp-avante" = {
            enable = true;
            package = pkgs.vimPlugins.blink-cmp-avante;
            module = "blink-cmp-avante";
          };
        */
      };
      setupOpts = {
        completion = {
          list = {
            cycle_from_bottom = true;
          };
          accept = {
            auto_brackets = {
              enabled = true;
            };
          };
          menu = {
            #auto_show = true;
            draw = {
              treesitter = [ "lsp" ];
              columns = [
                (lua ''{ 'item_idx' }, { 'kind_icon' }, { 'label', 'label_description', gap = 1 }'')
              ];
              components = {
                item_idx = {
                  text = lua ''function(ctx) return ctx.idx == 10 and '0' or ctx.idx >= 10 and ' ' or tostring(ctx.idx) end'';
                  highlight = "BlinkCmpItemIdx"; # optional, only if you want to change its color
                };
              };
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
        keymap = {
          preset = "none";
          "<Esc>" = [
            "hide"
            "fallback"
          ];
          "<Tab>" = [
            "select_and_accept"
            "fallback"
          ];
          "<C-n>" = [
            "select_next"
            "fallback_to_mappings"
          ];
          "<C-p>" = [
            "select_prev"
            "fallback_to_mappings"
          ];
          "<Down>" = [
            "select_next"
            "fallback"
          ];
          "<Up>" = [
            "select_prev"
            "fallback"
          ];
          "j" = [
            "select_next"
            "fallback"
          ];
          "k" = [
            "select_prev"
            "fallback"
          ];
          "<A-1>" = [ (lua ''function(cmp) cmp.accept({ index = 1 }) end'') ];
          "<A-2>" = [ (lua ''function(cmp) cmp.accept({ index = 2 }) end'') ];
          "<A-3>" = [ (lua ''function(cmp) cmp.accept({ index = 3 }) end'') ];
          "<A-4>" = [ (lua ''function(cmp) cmp.accept({ index = 4 }) end'') ];
          "<A-5>" = [ (lua ''function(cmp) cmp.accept({ index = 5 }) end'') ];
          "<A-6>" = [ (lua ''function(cmp) cmp.accept({ index = 6 }) end'') ];
          "<A-7>" = [ (lua ''function(cmp) cmp.accept({ index = 7 }) end'') ];
          "<A-8>" = [ (lua ''function(cmp) cmp.accept({ index = 8 }) end'') ];
          "<A-9>" = [ (lua ''function(cmp) cmp.accept({ index = 9 }) end'') ];
          "<A-0>" = [ (lua ''function(cmp) cmp.accept({ index = 10 }) end'') ];
        };
        sources = {
          default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
            "copilot"
            # "avante"
          ];
          providers = {
            copilot = {
              name = "copilot";
              module = "blink-copilot";
              # kind = "Copilot";
              score_offset = 100;
              async = true;
            };
            /*
              avante = {
                name = "avante";
                module = "blink-cmp-avante";
              };
              avante_commands = {
                name = "avante_commands";
                module = "blink.compat.source";
                score_offset = 90; # show at a higher priority than lsp
                opts = { };
              };
              avante_files = {
                name = "avante_files";
                module = "blink.compat.source";
                score_offset = 100; # show at a higher priority than lsp
                opts = { };
              };
              avante_mentions = {
                name = "avante_mentions";
                module = "blink.compat.source";
                score_offset = 1000; # show at a higher priority than lsp
                opts = { };
              };
              avante_shortcuts = {
                name = "avante_shortcuts";
                module = "blink.compat.source";
                score_offset = 1000; # show at a higher priority than lsp
                opts = { };
              };
            */
          };
        };
        snippets = {
          preset = "luasnip";
        };
      };
    };
  };
}
