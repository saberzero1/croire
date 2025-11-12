{ lib, ... }:
let
  lua = lib.mkLuaInline;
in
{
  programs.nvf.settings.vim.navigation = {
    harpoon = {
      enable = true;
    };
  };
  programs.nvf.settings.vim.minimap = {
    minimap-vim = {
      enable = false;
    };
    codewindow = {
      enable = true;
    };
  };
  programs.nvf.settings.vim.utility.snacks-nvim = {
    enable = true;
    setupOpts = {
      dashboard = {
        enabled = false;
      };
      bigfile = {
        enabled = true;
      };
      quickfile = {
        enabled = true;
      };
      terminal = {
      };
      indent = {
        enabled = true;
      };
      input = {
        enabled = true;
      };
      notifier = {
        enabled = true;
      };
      notify = {
        enabled = true;
      };
      scope = {
        enabled = true;
      };
      scroll = {
        enabled = true;
      };
      statuscolumn = {
        enabled = true;
      };
      toggle = {
        enabled = true;
      };
      words = {
        enabled = true;
      };
      picker = {
        enabled = true;
        ui_select = true;
      };
    };
  };
  programs.nvf.settings.vim.telescope = {
    enable = true;
    extensions = [
      {
        name = "yank_history";
        setup = {
          yank_history = { };
        };
      }
    ];
  };
}
