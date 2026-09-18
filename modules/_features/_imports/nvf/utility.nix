{ pkgs, ... }:
let
  plugin = pkgs.vimPlugins;
in
{
  programs.nvf.settings.vim.lazy.plugins = {
    "grug-far.nvim" = {
      enabled = true;
      package = plugin.grug-far-nvim;
      cmd = "GrugFar";
      setupOpts = { };
      keys = [
        {
          key = "<leader>sr";
          action = ''
            function()
              local grug = require("grug-far")
              local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
              grug.open({
                transient = true,
                prefills = {
                  filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                },
              })
            end
          '';
          lua = true;
          mode = [
            "n"
            "v"
          ];
          desc = "Search and Replace";
        }
      ];
    };
    # yanky itself is configured through nvf's native module below (that is
    # what pulls in sqlite-lua); only the keymaps are attached here, since the
    # nvf module deliberately ships none.
    "yanky-nvim" = {
      keys = [
        {
          key = "<leader>p";
          mode = [
            "n"
            "x"
          ];
          action = ''
            function()
              local picker = require("telescope")
              if picker ~= nil then
                picker.extensions.yank_history.yank_history({})
              end
            end
          '';
          lua = true;
          desc = "Open Yank History";
        }
        {
          key = "y";
          mode = [
            "n"
            "x"
          ];
          action = "<Plug>(YankyYank)";
          desc = "Yank Text";
        }
        {
          key = "p";
          mode = [
            "n"
            "x"
          ];
          action = "<Plug>(YankyPutAfter)";
          desc = "Put Text After Cursor";
        }
        {
          key = "P";
          mode = [
            "n"
            "x"
          ];
          action = "<Plug>(YankyPutBefore)";
          desc = "Put Text Before Cursor";
        }
        {
          key = "gp";
          mode = [
            "n"
            "x"
          ];
          action = "<Plug>(YankyGPutAfter)";
          desc = "Put Text After Selection";
        }
        {
          key = "gP";
          mode = [
            "n"
            "x"
          ];
          action = "<Plug>(YankyGPutBefore)";
          desc = "Put Text Before Selection";
        }
        {
          key = "[y";
          mode = "n";
          action = "<Plug>(YankyCycleForward)";
          desc = "Cycle Forward Through Yank History";
        }
        {
          key = "]y";
          mode = "n";
          action = "<Plug>(YankyCycleBackward)";
          desc = "Cycle Backward Through Yank History";
        }
      ];
    };
  };

  # Native nvf module: setting ring.storage = "sqlite" makes nvf add
  # pkgs.vimPlugins.sqlite-lua to startPlugins automatically. The previous
  # hand-rolled lazy.plugins entry bypassed that, which is exactly why sqlite
  # was configured but the dependency was never installed.
  #
  # sqlite over shada because multiple concurrent nvim instances are the norm
  # here: shada rewrites the whole vim.g.YANKY_HISTORY global on exit, so
  # last-writer-wins and one instance's yanks are silently discarded. shada
  # also caps the ENTIRE history at the 'shada' s-flag (default s10 = 10 KiB)
  # and drops all of it once exceeded. sqlite INSERTs per yank into a shared
  # db (stdpath("data")/databases/yanky.db), so instances accumulate correctly,
  # there is no size cliff, and yanks survive a crash rather than only a clean
  # exit.
  programs.nvf.settings.vim.utility.yanky-nvim = {
    enable = true;
    setupOpts = {
      ring.storage = "sqlite";
      highlight = {
        on_put = true;
        on_yank = true;
        timer = 150;
      };
      picker.telescope.use_default_mappings = true;
    };
  };

  programs.nvf.settings.vim.utility = {
    # direnv dropped: nvf wires every LSP/formatter by absolute Nix store path,
    # so Neovim's PATH is irrelevant to tooling and direnv.vim bought nothing.
    #
    # motion: flash-nvim (motion.nix) is the jump plugin -- hop and leap were
    # never enabled, and precognition's hint virtual-text was visual noise
    # (hardtime-nvim was already off for the same reason).
    #
    # multicursors: evaluated and dropped.
    #
    # surround dropped: mini.surround (coding.nix) owns gsa/gsd/gsr/gsf/gsF/
    # gsh/gsn and has a `gs` which-key group. Enabling this too installed
    # nvim-surround alongside it, giving two implementations on cs/ys/ds.
    undotree = {
      enable = true;
    };
  };
}
