{
  programs.nvf.settings.vim = {
    mini.icons.enable = true;
    # nvf's alpha and bufferline modules pull in nvim-web-devicons regardless,
    # so both icon providers load. Routing web-devicons through mini.icons gives
    # one icon table instead of two independent ones.
    luaConfigRC.mini-icons-mock = ''
      require("mini.icons").mock_nvim_web_devicons()
    '';

    # Breadcrumbs (nvim-navic + navbuddy) removed. They render into nvf's
    # lualine module, but vim.statusline.lualine.enable defaults to false and
    # is never set here -- the real statusline is the hand-rolled lualine lazy
    # plugin in statusline.nix, which has no navic component. Net result was
    # nvim-navic, nvim-navbuddy and nui-nvim installed with no reachable UI and
    # no keybind to open :Navbuddy. Trouble symbols on <leader>cs covers this.
    ui = {
      borders = {
        enable = true;
        globalStyle = "rounded";
        plugins = {
          which-key = {
            enable = true;
          };
        };
      };
      colorizer = {
        enable = true;
      };
      fastaction = {
        enable = true;
      };
      illuminate = {
        enable = true;
      };
      noice = {
        enable = true;
        setupOpts = {
          lsp = {
            override = {
              "vim.lsp.util.convert_input_to_markdown_lines" = true;
              "vim.lsp.util.stylize_markdown" = true;
              # "cmp.entry.get_documentation" = true; # Dead with blink-cmp (nvim-cmp specific)
            };
            signature = {
              enabled = true;
              auto_open = {
                enabled = true;
                trigger = true;
                luasnip = true;
                throttle = 50;
              };
            };
          };
          routes = [
            {
              filter = {
                event = "msg_show";
                any = [
                  { find = "%d+L, %d+B"; }
                  { find = "; after #%d+"; }
                  { find = "; before #%d+"; }
                ];
              };
              view = "mini";
            }
          ];
          presets = {
            bottom_search = true;
            command_palette = true;
            long_message_to_split = true;
          };
        };
      };
      smartcolumn = {
        enable = true;
        setupOpts = {
          colorcolumn = "80";
          disabled_filetypes = [
            "help"
            "text"
            "markdown"
            "NvimTree"
            "alpha"
            "dashboard"
            "ministarter"
            "snacks_dashboard"
            "startify"
          ];
        };
      };
    };
  };
}
