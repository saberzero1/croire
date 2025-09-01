{ pkgs, lib, ... }:
let
  lua = lib.mkLuaInline;
in
{
  programs.nvf.settings.vim = {
    treesitter = {
      enable = true;
      addDefaultGrammars = true;
      context = {
        enable = true;
      };
      fold = true;
      grammars = with pkgs.vimPlugins.nvim-treesitter; [ withAllGrammars ];
      highlight = {
        enable = true;
      };
      textobjects = {
        enable = true;
      };
    };
    mini.ai = {
      enable = true;
      setupOpts = {
        n_lines = 500;
        search_method = "cover";
        custom_textobjects = {
          o = lua ''
            require("mini.ai").gen_spec.treesitter({ -- code block
              a = { "@block.outer", "@conditional.outer", "@loop.outer" },
              i = { "@block.inner", "@conditional.inner", "@loop.inner" },
            })
          '';
          f = lua ''
            require("mini.ai").gen_spec.treesitter({ -- function
              a = "@function.outer",
              i = "@function.inner",
            })
          '';
          c = lua ''
            require("mini.ai").gen_spec.treesitter({ -- class
              a = "@class.outer",
              i = "@class.inner",
            })
          '';
          t = lua ''
            { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" } -- tags
          '';
          d = lua ''
            { "%f[%d]%d+" } -- digits
          '';
          e = lua ''
            { -- Word with case
              { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
              "^().*()$",
            }
          '';
          # g = LazyVim.mini.ai_buffer, -- buffer
          u = lua ''
            require("mini.ai").gen_spec.function_call() -- u for "Usage"
          '';
          U = lua ''
            require("mini.ai").gen_spec.function_call({ name_pattern = "[%w_]" }) -- without dot in function name 
          '';
        };
      };
    };
  };
}
