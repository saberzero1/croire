{ lib, ... }:
let
  lua = lib.mkLuaInline;
in
{
  programs.nvf.settings.vim.lazy.plugins."gitsigns-nvim" = {
    enabled = true;
    package = "gitsigns-nvim";
    setupOpts = {
      signs = {
        add = {
          text = "▎";
        };
        change = {
          text = "▎";
        };
        delete = {
          text = "";
        };
        topdelete = {
          text = "";
        };
        changedelete = {
          text = "▎";
        };
        untracked = {
          text = "▎";
        };
      };
      signs_staged = {
        add = {
          text = "▎";
        };
        change = {
          text = "▎";
        };
        delete = {
          text = "";
        };
        topdelete = {
          text = "";
        };
        changedelete = {
          text = "▎";
        };
      };
      on_attach = lua ''
        return function(buffer)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
          end

          -- stylua: ignore start
          map("n", "]h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gs.nav_hunk("next")
            end
          end, "Next Hunk")
          map("n", "[h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gs.nav_hunk("prev")
            end
          end, "Prev Hunk")
          map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
          map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
          map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
          map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
          map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
          map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
          map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
          map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
          map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
          map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
          map("n", "<leader>ghd", gs.diffthis, "Diff This")
          map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
          -- stylua: ignore end
        end
      '';
    };
  };
  programs.nvf.settings.vim.binds.whichKey = {
    setupOpts = {
      preset = "helix";
      defaults = { };
      sort = [
        "local" # local before global
        "order" # marks/registers before others
        (lua ''function(item) return item.group and 0 or 1 end'') # groups before non-groups
        "alphanum" # alphanumerical
        "mod" # special modifiers last
      ];
      spec = lua ''
        {
          {
            mode = { "n", "v" },
            { "<leader><tab>", group = "tabs" },
            { "<leader>c", group = "code" },
            { "<leader>d", group = "debug" },
            { "<leader>dp", group = "profiler" },
            { "<leader>f", group = "file/find" },
            { "<leader>g", group = "git" },
            { "<leader>gh", group = "hunks" },
            { "<leader>q", group = "quit/session" },
            { "<leader>s", group = "search" },
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
  };
}
