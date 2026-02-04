{ lib, ... }:
let
  lua = lib.mkLuaInline;
  keymap = key: command: [
    "n"
    "${key}"
    "<cmd>${command}<cr>"
    {
      noremap = true;
      silent = true;
      nowait = true;
    }
  ];
in
{
  programs.nvf.settings.vim.dashboard.alpha = {
    enable = true;
    theme = null;
    layout = [
      {
        type = "padding";
        val = 2;
      }
      {
        type = "text";
        val = [
          "  ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆         "
          "   ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦      "
          "         ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄    "
          "          ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄   "
          "         ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀ "
          "  ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄ "
          " ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄  "
          "⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄ "
          "⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄"
          "     ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆    "
          "      ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃   "
        ];
        opts = {
          position = "center";
          hl = "Type";
        };
      }
      {
        type = "padding";
        val = 2;
      }
      {
        type = "group";
        val = [
          {
            type = "button";
            val = " New File";
            on_press = ":ene | startinsert";
            opts = {
              position = "center";
              shortcut = "n";
              keymap = keymap "n" "ene | startinsert";
              cursor = 3;
              width = 50;
              align_shortcut = "right";
              hl_shortcut = "Keyword";
            };
          }
          {
            type = "button";
            val = " Find File";
            on_press = "<cmd>Telescope find_files<cr>";
            opts = {
              position = "center";
              shortcut = "f";
              keymap = keymap "f" "Telescope find_files";
              cursor = 3;
              width = 50;
              align_shortcut = "right";
              hl_shortcut = "Keyword";
            };
          }
          {
            type = "button";
            val = " Find Text";
            on_press = "<cmd>Telescope live_grep<cr>";
            opts = {
              position = "center";
              shortcut = "g";
              keymap = keymap "g" "Telescope live_grep";
              cursor = 3;
              width = 50;
              align_shortcut = "right";
              hl_shortcut = "Keyword";
            };
          }
          {
            type = "button";
            val = " Recent Files";
            on_press = "<cmd>Telescope oldfiles<cr>";
            opts = {
              position = "center";
              shortcut = "r";
              keymap = keymap "r" "Telescope oldfiles";
              cursor = 3;
              width = 50;
              align_shortcut = "right";
              hl_shortcut = "Keyword";
            };
          }
          #{ icon = " "; key = "c"; desc = "Config"; action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})"; }
          {
            type = "button";
            val = " Restore Session";
            on_press = lua ''
              function()
                require('persistence').load()
              end
            '';
            opts = {
              position = "center";
              shortcut = "s";
              keymap = keymap "s" "lua require('persistence').load()";
              cursor = 3;
              width = 50;
              align_shortcut = "right";
              hl_shortcut = "Keyword";
            };
            #section = "session";
          }
          #{ icon = "󰒲 "; key = "L"; desc = "Lazy"; action = ":Lazy"; enabled = package.loaded.lazy ~= nil; }
          {
            type = "button";
            val = " Check Config";
            on_press = ":checkhealth";
            opts = {
              position = "center";
              shortcut = "h";
              keymap = keymap "h" "checkhealth";
              cursor = 3;
              width = 50;
              align_shortcut = "right";
              hl_shortcut = "Keyword";
            };
          }
          {
            type = "button";
            val = " Quit";
            on_press = ":qa";
            opts = {
              position = "center";
              shortcut = "q";
              keymap = keymap "q" "qa";
              cursor = 3;
              width = 50;
              align_shortcut = "right";
              hl_shortcut = "Keyword";
            };
          }
        ];
        opts = {
          spacing = 1;
          position = "center";
          hl = "Function";
        };
      }
    ];
  };
}
