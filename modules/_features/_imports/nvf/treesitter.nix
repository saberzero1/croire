{ lib, ... }:
let
  lua = lib.mkLuaInline;
in
{
  programs.nvf.settings.vim.treesitter = {
    enable = true;
    autotagHtml = true;
    # Grammars come from the per-language modules in languages.nix via their
    # `treesitter.enable`. Previously this file also carried a hand-maintained
    # 90-entry grammar list AND `addDefaultGrammars = true`, so grammars were
    # declared three separate ways and 106 parsers were installed.
    context = {
      enable = true;
    };
    fold = true;
    highlight = {
      enable = true;
    };
    indent = {
      enable = true;
    };
    # Required, not optional: mini.ai's `o`/`f`/`c` textobjects below call
    # gen_spec.treesitter(), which resolves captures from the `textobjects`
    # query group. That group ships with nvim-treesitter-textobjects, so with
    # this disabled `daf`/`dac`/`dao` were silently no-ops.
    textobjects = {
      enable = true;
      # setupOpts intentionally empty. nvim-treesitter here is the `main`
      # branch (require("nvim-treesitter.configs") no longer exists), and on
      # main the textobjects `move` table is NOT read to create keymaps -- the
      # old `move.goto_next_start = { ... }` form silently bound nothing. The
      # motions are declared explicitly below against the main-branch API.
      setupOpts = { };
    };
  };

  # Treesitter function motions, using the main-branch
  # nvim-treesitter-textobjects.move API.
  #
  # ]f/[f are free because unimpaired (which bound them to directory/qflist
  # navigation) has been removed.
  #
  # Deliberately NO ]c/[c/]C/[C: those are Vim's native diff-mode
  # next/prev-change motions, and gitsigns' ]h/[h handlers delegate to them
  # when vim.wo.diff is set. Parameter motions are skipped too -- ]a/[a are
  # already taken by other mappings.
  programs.nvf.settings.vim.keymaps =
    let
      motion = key: fn: capture: desc: {
        inherit key desc;
        mode = [
          "n"
          "x"
          "o"
        ];
        lua = true;
        action = ''
          function()
            require("nvim-treesitter-textobjects.move").${fn}("${capture}", "textobjects")
          end
        '';
      };
    in
    [
      (motion "]f" "goto_next_start" "@function.outer" "Next Function Start")
      (motion "[f" "goto_previous_start" "@function.outer" "Prev Function Start")
      (motion "]F" "goto_next_end" "@function.outer" "Next Function End")
      (motion "[F" "goto_previous_end" "@function.outer" "Prev Function End")
    ];
  programs.nvf.settings.vim.mini.ai = {
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
        u = lua ''
          require("mini.ai").gen_spec.function_call() -- u for "Usage"
        '';
        U = lua ''
          require("mini.ai").gen_spec.function_call({ name_pattern = "[%w_]" }) -- without dot in function name
        '';
      };
    };
  };
}
