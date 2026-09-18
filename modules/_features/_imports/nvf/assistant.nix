{
  programs.nvf.settings.vim.assistant = {
    copilot = {
      enable = true;
      # cmp.enable registers a Copilot source for nvim-cmp, which isn't
      # installed -- blink-cmp gets Copilot from the blink-copilot source
      # plugin declared in autocomplete.nix.
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
