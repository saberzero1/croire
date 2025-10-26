{
  programs.nvf.settings.vim.assistant = {
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
