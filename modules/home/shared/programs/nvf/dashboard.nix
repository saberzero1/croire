{ lib, ... }:
{
  programs.nvf.settings.vim.utility.snacks-nvim.setupOpts.dashboard = {
    enabled = true;
    preset = {
      #-- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
      #---@type fun(cmd:string, opts:table)|nil
      pick = null;
      #-- Used by the `keys` section to show keymaps.
      #-- Set your custom keymaps here.
      #-- When using a function, the `items` argument are the default keymaps.
      #---@type snacks.dashboard.Item[]
      keys = [
        {
          icon = " ";
          key = "n";
          desc = "New File";
          action = ":ene | startinsert";
        }
        {
          icon = " ";
          key = "f";
          desc = "Find File";
          action = ":lua Snacks.dashboard.pick('files')";
        }
        {
          icon = " ";
          key = "g";
          desc = "Find Text";
          action = ":lua Snacks.dashboard.pick('live_grep')";
        }
        {
          icon = " ";
          key = "r";
          desc = "Recent Files";
          action = ":lua Snacks.dashboard.pick('oldfiles')";
        }
        #{ icon = " "; key = "c"; desc = "Config"; action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})"; }
        {
          icon = " ";
          key = "s";
          desc = "Restore Session";
          action = lib.mkLuaInline ''
            function()
              require('persistence').load()
            end
          '';
          #section = "session";
        }
        #{ icon = "󰒲 "; key = "L"; desc = "Lazy"; action = ":Lazy"; enabled = package.loaded.lazy ~= nil; }
        {
          icon = " ";
          key = "c";
          desc = "Check Config";
          action = ":checkhealth";
        }
        {
          icon = " ";
          key = "q";
          desc = "Quit";
          action = ":qa";
        }
      ];
      #-- Used by the `header` section
      header = ''
        ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
        ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
        ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
        ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
        ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
        ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
      '';
    };
    sections = [
      { section = "header"; }
      {
        section = "keys";
        gap = 1;
        padding = 1;
      }
    ];
  };
}
