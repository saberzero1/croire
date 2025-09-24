let
  ai_cmp = true;
in
{
  programs.nvf.settings.vim.assistant = {
    avante-nvim = {
      enable = false;
      setupOpts = {
        auto_suggestions_provider = "copilot";
        behavior = {
          auto_suggestions = ai_cmp;
        };
        provider = "copilot";
        input = {
          provider = "snacks";
          provider_opts = {
            title = "Avante Input";
            icon = " ";
          };
        };
      };
    };
    copilot = {
      enable = true;
      cmp.enable = true;
      setupOpts = {
        panel.enabled = false;
        suggestion.enabled = false;
        filetypes = {
          markdown = true;
          help = true;
        };
      };
      mappings = {
        panel = {
          accept = null;
          jumpNext = null;
          jumpPrev = null;
          open = null;
          refresh = null;
        };
        suggestion = {
          accept = null;
          next = null;
          prev = null;
        };
      };
    };
  };
}
