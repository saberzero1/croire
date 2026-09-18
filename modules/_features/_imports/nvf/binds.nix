{ lib, ... }:
let
  lua = lib.mkLuaInline;
in
{
  # cheatsheet-nvim dropped: it had no keybinding (cmd-only :Cheatsheet) and
  # overlapped both which-key and Telescope's <leader>sk keymap picker.
  #
  # hardtime-nvim stays off -- precognition was the motion-hint tool here, and
  # it's been dropped too now that the motions are muscle memory.
  programs.nvf.settings.vim.binds.whichKey.enable = true;

  # Border style is declared only here; ui.nix used to set the same option.
  programs.nvf.settings.vim.ui.borders.plugins.which-key = {
    enable = true;
    style = "rounded";
  };

  # Single source of truth for which-key groups. This spec used to live in
  # git.nix, with tabline.nix separately declaring overlapping <leader>b /
  # <leader>s / <leader>sn groups via binds.whichKey.register.
  programs.nvf.settings.vim.binds.whichKey.setupOpts = {
    preset = "helix";
    defaults = { };
    sort = [
      "local" # local before global
      "order" # marks/registers before others
      (lua "function(item) return item.group and 0 or 1 end") # groups before non-groups
      "alphanum" # alphanumerical
      "mod" # special modifiers last
    ];
    spec = lua ''
      {
        {
          mode = { "n", "v" },
          { "<leader><tab>", group = "tabs" },
          { "<leader>c", group = "code" },
          { "<leader>cw", group = "workspace" },
          { "<leader>d", group = "debug" },
          { "<leader>dp", group = "profiler" },
          { "<leader>f", group = "file/find" },
          { "<leader>g", group = "git" },
          { "<leader>gh", group = "hunks" },
          { "<leader>h", group = "health" },
          { "<leader>q", group = "quit/session" },
          { "<leader>s", group = "search" },
          { "<leader>sn", group = "noice" },
          { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
          { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "gs", group = "surround" },
          { "z", group = "fold" },
          {
            "<leader>b",
            group = "buffer",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },
          {
            "<leader>w",
            group = "windows",
            proxy = "<c-w>",
            expand = function()
              return require("which-key.extras").expand.win()
            end,
          },
          -- better descriptions
          { "gx", desc = "Open with system app" },
        },
      }
    '';
  };
}
