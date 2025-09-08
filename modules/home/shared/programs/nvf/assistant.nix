{ ... }:
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
          enabled = true;
          auto_trigger = true;
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
          accept = "<Tab>";
          acceptLine = "<C-Tab>";
          acceptWord = "<S-Tab>";
          dismiss = "<C-]>";
          next = "<M-]>";
          prev = "<M-[";
        };
      };
    };
  };
}
