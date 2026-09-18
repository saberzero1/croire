{
  programs.nvf.settings.vim.formatter.conform-nvim = {
    enable = true;
    setupOpts = {
      default_format_opts = {
        timeout_ms = 3000;
        async = true;
        quiet = false;
        lsp_format = "fallback";
      };
      # Per-filetype formatters come from the language modules in languages.nix
      # (lua -> stylua, bash -> shfmt, fish -> fish-indent, ...). Repeating them
      # here only risked the two definitions drifting apart.
      formatters_by_ft = { };
      formatters.injected.options.ignore_errors = true;
    };
  };
}
