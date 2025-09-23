let
  ai_cmp = true;
in
{
  programs.nvf.settings.vim.assistant = {
    avante-nvim = {
      enable = false;
      setupOpts = {
        auto_suggestions_provider = "copilot";
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
        suggestion = {
          enabled = !ai_cmp;
          auto_trigger = true;
          hide_during_completion = ai_cmp;
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
          next = "<M-]>";
          prev = "<M-[";
        };
      };
    };
  };
}
