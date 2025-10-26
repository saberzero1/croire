{
  programs.nvf.settings.vim.snippets = {
    luasnip = {
      enable = true;
      loaders = ''
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
      '';
      providers = [
        "luasnip"
        "friendly-snippets"
      ];
      setupOpts = {
        history = true;
        delete_check_events = "TextChanged";
      };
    };
  };
}
