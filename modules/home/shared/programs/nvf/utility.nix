{ pkgs, lib, ... }:
let
  plugin = pkgs.vimPlugins;
  lua = lib.mkLuaInline;
in
{
  programs.nvf.settings.vim = {
    lazy.plugins = {
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
      "plenary-nvim" = {
        enabled = true;
        package = "plenary-nvim";
        lazy = false;
      };
    };
    utility = {
      direnv = {
        enable = false;
      };
      motion = {
        hop = {
          enable = false;
        };
        leap = {
          enable = false;
        };
        precognition = {
          enable = true;
          setupOpts = {
            disabled_fts = [
              "alpha"
              "dashboard"
              "ministarter"
              "snacks_dashboard"
              "startify"
            ];
          };
        };
      };
      multicursors = {
        enable = false;
      };
      surround = {
        enable = true;
      };
      undotree = {
        enable = true;
      };
    };
  };
}
