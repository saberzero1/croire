{ pkgs, ... }:
let
  inherit (builtins)
    all
    isBool
    isString
    isList
    ;
  isStringOrNull = x: isString x || x == null;
  plugin = pkgs.vimPlugins;
  mkKeyMap =
    { action
    , key ? null
    , mode ? "n"
    , desc ? null
    , expr ? false
    , lua ? false
    , noremap ? true
    , nowait ? false
    , script ? false
    , silent ? true
    , unique ? false
    ,
    }:
      assert (isString action);
      assert (isString key);
      assert (isString mode) || (isList mode && all isString mode);
      assert (isStringOrNull desc);
      assert (isBool expr);
      assert (isBool lua);
      assert (isBool noremap);
      assert (isBool nowait);
      assert (isBool script);
      assert (isBool silent);
      assert (isBool unique);
      {
        inherit
          action
          key
          mode
          desc
          expr
          lua
          noremap
          nowait
          script
          silent
          unique
          ;
      };
in
{
  programs.nvf.settings.vim = {
    keymaps = [
      # Better up/down
      (mkKeyMap {
        action = "v:count == 0 ? 'gj' : 'j'";
        key = "j";
        mode = [
          "n"
          "x"
        ];
        expr = true;
        desc = "Down";
      })
      (mkKeyMap {
        action = "v:count == 0 ? 'gj' : 'j'";
        key = "<Down>";
        mode = [
          "n"
          "x"
        ];
        expr = true;
        desc = "Down";
      })
      (mkKeyMap {
        action = "v:count == 0 ? 'gk' : 'k'";
        key = "k";
        mode = [
          "n"
          "x"
        ];
        expr = true;
        desc = "Up";
      })
      (mkKeyMap {
        action = "v:count == 0 ? 'gk' : 'k'";
        key = "<Up>";
        mode = [
          "n"
          "x"
        ];
        expr = true;
        desc = "Up";
      })
      # Move to window using the <ctrl> hjkl keys
      (mkKeyMap {
        action = "<C-w>h";
        key = "<C-h>";
        mode = "n";
        desc = "Go to Left Window";
        noremap = false;
      })
      (mkKeyMap {
        action = "<C-w>j";
        key = "<C-j>";
        mode = "n";
        desc = "Go to Lower Window";
        noremap = false;
      })
      (mkKeyMap {
        action = "<C-w>k";
        key = "<C-k>";
        mode = "n";
        desc = "Go to Upper Window";
        noremap = false;
      })
      (mkKeyMap {
        action = "<C-w>l";
        key = "<C-l>";
        mode = "n";
        desc = "Go to Right Window";
        noremap = false;
      })
      # Resize window using <ctrl> arrow keys
      (mkKeyMap {
        action = "<cmd>resize +2<cr>";
        key = "<C-Up>";
        mode = "n";
        desc = "Increase Window Height";
      })
      (mkKeyMap {
        action = "<cmd>resize -2<cr>";
        key = "<C-Down>";
        mode = "n";
        desc = "Decrease Window Height";
      })
      (mkKeyMap {
        action = "<cmd>vertical resize -2<cr>";
        key = "<C-Left>";
        mode = "n";
        desc = "Decrease Window Width";
      })
      (mkKeyMap {
        action = "<cmd>vertical resize +2<cr>";
        key = "<C-Right>";
        mode = "n";
        desc = "Increase Window Width";
      })
      # Move Lines
      (mkKeyMap {
        action = "<cmd>execute 'move .+' . v:count1<cr>==";
        key = "<A-j>";
        mode = "n";
        desc = "Move Down";
      })
      (mkKeyMap {
        action = "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==";
        key = "<A-k>";
        mode = "n";
        desc = "Move Up";
      })
      (mkKeyMap {
        action = "<esc><cmd>m .+1<cr>==gi";
        key = "<A-j>";
        mode = "i";
        desc = "Move Down";
      })
      (mkKeyMap {
        action = "<esc><cmd>m .-2<cr>==gi";
        key = "<A-k>";
        mode = "i";
        desc = "Move Up";
      })
      (mkKeyMap {
        action = ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv";
        key = "<A-j>";
        mode = "v";
        desc = "Move Down";
      })
      (mkKeyMap {
        action = ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv";
        key = "<A-k>";
        mode = "v";
        desc = "Move Up";
      })
      # Buffers
      (mkKeyMap {
        action = "<cmd>bprevious<cr>";
        key = "<S-h>";
        mode = "n";
        desc = "Prev Buffer";
      })
      (mkKeyMap {
        action = "<cmd>bnext<cr>";
        key = "<S-l>";
        mode = "n";
        desc = "Next Buffer";
      })
      (mkKeyMap {
        action = "<cmd>bprevious<cr>";
        key = "[b";
        mode = "n";
        desc = "Prev Buffer";
      })
      (mkKeyMap {
        action = "<cmd>bnext<cr>";
        key = "]b";
        mode = "n";
        desc = "Next Buffer";
      })
      (mkKeyMap {
        action = "<cmd>e #<cr>";
        key = "<leader>bb";
        mode = "n";
        desc = "Switch to Other Buffer";
      })
      (mkKeyMap {
        action = "<cmd>e #<cr>";
        key = "<leader>`";
        mode = "n";
        desc = "Switch to Other Buffer";
      })
      (mkKeyMap {
        action = ''
          function()
            require("snacks").bufdelete()
          end
        '';
        key = "<leader>bd";
        mode = "n";
        lua = true;
        desc = "Delete Buffer";
      })
      (mkKeyMap {
        action = ''
          function()
            require("snacks").bufdelete.other()
          end
        '';
        key = "<leader>bo";
        mode = "n";
        lua = true;
        desc = "Delete Other Buffers";
      })
      (mkKeyMap {
        action = "<cmd>:bd<cr>";
        key = "<leader>bD";
        mode = "n";
        desc = "Delete Buffer and Window";
      })
      # Clear search, diff update and redraw
      # taken from runtime/lua/_editor.lua
      (mkKeyMap {
        action = "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>";
        key = "<leader>ur";
        mode = "n";
        desc = "Redraw / Clear hlsearch / Diff Update";
      })
      # https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
      (mkKeyMap {
        action = "'Nn'[v:searchforward].'zv'";
        key = "n";
        mode = "n";
        expr = true;
        desc = "Next Search Result";
      })
      (mkKeyMap {
        action = "'Nn'[v:searchforward]";
        key = "n";
        mode = "x";
        expr = true;
        desc = "Next Search Result";
      })
      (mkKeyMap {
        action = "'Nn'[v:searchforward]";
        key = "n";
        mode = "o";
        expr = true;
        desc = "Next Search Result";
      })
      (mkKeyMap {
        action = "'nN'[v:searchforward].'zv'";
        key = "N";
        mode = "n";
        expr = true;
        desc = "Prev Search Result";
      })
      (mkKeyMap {
        action = "'nN'[v:searchforward]";
        key = "N";
        mode = "x";
        expr = true;
        desc = "Prev Search Result";
      })
      (mkKeyMap {
        action = "'nN'[v:searchforward]";
        key = "N";
        mode = "o";
        expr = true;
        desc = "Prev Search Result";
      })
      # Add undo break-points
      (mkKeyMap {
        action = ",<c-g>u";
        key = ",";
        mode = "i";
      })
      (mkKeyMap {
        action = ".<c-g>u";
        key = ".";
        mode = "i";
      })
      (mkKeyMap {
        action = ";<c-g>u";
        key = ";";
        mode = "i";
      })
      # Save file
      (mkKeyMap {
        action = "<cmd>w<cr><esc>";
        key = "<C-s>";
        mode = [
          "i"
          "x"
          "n"
          "s"
        ];
        desc = "Save File";
      })
      # Keywordprg
      (mkKeyMap {
        action = "<cmd>norm! K<cr>";
        key = "<leader>K";
        mode = "n";
        desc = "Keywordprg";
      })
      # Better indenting
      (mkKeyMap {
        action = "<gv";
        key = "<";
        mode = "v";
        desc = "Indent Left";
      })
      (mkKeyMap {
        action = ">gv";
        key = ">";
        mode = "v";
        desc = "Indent Right";
      })
      # Commenting
      (mkKeyMap {
        action = "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
        key = "gco";
        mode = "n";
        desc = "Add Comment Below";
      })
      (mkKeyMap {
        action = "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
        key = "gcO";
        mode = "n";
        desc = "Add Comment Above";
      })
      # Formatting
      (mkKeyMap {
        action = ''
          function()
            local conform = require("conform")
            if conform ~= nil then
              conform.format()
            else
              vim.lsp.buf.format()
            end
          end
        '';
        key = "<leader>cf";
        mode = [
          "n"
          "v"
        ];
        lua = true;
        desc = "Format";
      })
      # Diagnostics
      (mkKeyMap {
        action = "vim.diagnostic.open_float";
        key = "<leader>cd";
        mode = "n";
        lua = true;
        desc = "Line Diagnostics";
      })
      (mkKeyMap {
        action = ''
          function()
            vim.diagnostic.goto_next()
          end
        '';
        key = "]d";
        mode = "n";
        lua = true;
        desc = "Next Diagnostic";
      })
      (mkKeyMap {
        action = ''
          function()
            vim.diagnostic.goto_prev()
          end
        '';
        key = "[d";
        mode = "n";
        lua = true;
        desc = "Prev Diagnostic";
      })
      (mkKeyMap {
        action = ''
          function()
            vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
          end
        '';
        key = "]e";
        mode = "n";
        lua = true;
        desc = "Next Error";
      })
      (mkKeyMap {
        action = ''
          function()
            vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
          end
        '';
        key = "[e";
        mode = "n";
        lua = true;
        desc = "Prev Error";
      })
      (mkKeyMap {
        action = ''
          function()
            vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
          end
        '';
        key = "]w";
        mode = "n";
        lua = true;
        desc = "Next Warning";
      })
      (mkKeyMap {
        action = ''
          function()
            vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
          end
        '';
        key = "[w";
        mode = "n";
        lua = true;
        desc = "Prev Warning";
      })
      # Lazygit
      (mkKeyMap {
        action = ''
          function()
            local function get()
              local root = vim.fn.expand('%:h')
              local git_root = vim.fs.find(".git", { path = root, upward = true })[1]
              local ret = git_root and vim.fn.fnamemodify(git_root, ":h") or root
              return ret
            end
            require("snacks").lazygit({ cwd = get() })
          end
        '';
        key = "<leader>gg";
        mode = "n";
        lua = true;
        desc = "Lazygit (Root Dir)";
      })
      (mkKeyMap {
        action = ''
          function()
            require("snacks").lazygit()
          end
        '';
        key = "<leader>gG";
        mode = "n";
        lua = true;
        desc = "Lazygit (cwd)";
      })
      (mkKeyMap {
        action = ''
          function()
            require("snacks").picker.git_log_file()
          end
        '';
        key = "<leader>gf";
        mode = "n";
        lua = true;
        desc = "Git Current File History";
      })
      (mkKeyMap {
        action = ''
          function()
            local function get()
              local root = vim.fn.expand('%:h')
              local git_root = vim.fs.find(".git", { path = root, upward = true })[1]
              local ret = git_root and vim.fn.fnamemodify(git_root, ":h") or root
              return ret
            end
            require("snacks").picker.git_log({ cwd = get() })
          end
        '';
        key = "<leader>gl";
        mode = "n";
        lua = true;
        desc = "Git Log";
      })
      (mkKeyMap {
        action = ''
          function()
            require("snacks").picker.git_log()
          end
        '';
        key = "<leader>gL";
        mode = "n";
        lua = true;
        desc = "Git Log (cwd)";
      })
      # Git
      (mkKeyMap {
        action = ''
          function()
            require("snacks").picker.git_log_line()
          end
        '';
        key = "<leader>gb";
        mode = "n";
        lua = true;
        desc = "Git Blame Line";
      })
      (mkKeyMap {
        action = ''
          function()
            require("snacks").gitbrowse()
          end
        '';
        key = "<leader>gB";
        mode = [
          "n"
          "x"
        ];
        lua = true;
        desc = "Git Browse (open)";
      })
      (mkKeyMap {
        action = ''
          function()
            require("snacks").gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false })
          end
        '';
        key = "<leader>gY";
        mode = [
          "n"
          "x"
        ];
        lua = true;
        desc = "Git Browse (copy)";
      })
    ];
    lazy.plugins = {
      "${plugin.unimpaired-nvim.pname}" = {
        enabled = true;
        package = plugin.unimpaired-nvim;
        setupModule = "unimpaired";
        setupOpts = {
          keymaps = {
            # space
            blank_above = false;
            blank_below = false;
            # a, A, ^A
            next = false;
            previous = false;
            first = false;
            last = false;
            # b, B, ^B
            bnext = false;
            bprevious = false;
            bfirst = false;
            blast = false;
            # q, Q, ^Q
            cnext = false;
            cprevious = false;
            cfirst = false;
            clast = false;
            cnfile = false;
            cpfile = false;
            # l, L, ^L
            lnext = false;
            lprevious = false;
            lfirst = false;
            llast = false;
            lnfile = false;
            lpfile = false;
            # t, t, ^T
            tnext = false;
            tprevious = false;
            tfirst = false;
            tlast = false;
            ptnext = false;
            ptprevious = false;
          };
        };
      };
    };
  };
}
