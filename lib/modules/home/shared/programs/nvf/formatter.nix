{
  programs.nvf.settings.vim.formatter.conform-nvim = {
    enable = true;
    setupOpts = {
      default_format_opts = {
        timeout_ms = 3000;
        async = false;
        quiet = false;
        lsp_format = "fallback";
      };
      formatters_by_ft = {
        lua = [ "stylua" ];
        fish = [ "fish_indent" ];
        sh = [ "shfmt" ];
      };
      formatters.injected.options.ignore_errors = true;
    };
  };
}
