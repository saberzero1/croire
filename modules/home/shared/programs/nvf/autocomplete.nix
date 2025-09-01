{ pkgs, ... }:
{
  programs.nvf.settings.vim.autocomplete = {
    enableSharedCmpSources = true;
    blink-cmp = {
      enable = true;
      friendly-snippets = {
        enable = true;
      };
      mappings = {
        confirm = "<CR>";
        complete = "<S-Space>";
        next = "<C-n>";
        previous = "<C-p>";
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
          menu = {
            auto_show = true;
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
