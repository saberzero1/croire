{
  programs.nvf.settings.vim.snippets = {
    luasnip = {
      enable = true;
      loaders = ''
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
      '';
      # `providers` already defaults to [ "friendly-snippets" ] upstream, and
      # blink-cmp.friendly-snippets requests it too -- declaring it a third
      # time added nothing.
      setupOpts = {
        history = true;
        delete_check_events = "TextChanged";
      };
    };
  };
}
