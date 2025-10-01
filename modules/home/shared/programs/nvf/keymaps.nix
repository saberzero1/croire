{ pkgs, ... }:
let
  plugin = pkgs.vimPlugins;
in
{
  programs.nvf.settings.vim.keymaps = [
    # Better up/down
    {
      action = "v:count == 0 ? 'gj' : 'j'";
      key = "j";
      mode = [
        "n"
        "x"
      ];
      expr = true;
      desc = "Down";
    }
    {
      action = "v:count == 0 ? 'gj' : 'j'";
      key = "<Down>";
      mode = [
        "n"
        "x"
      ];
      expr = true;
      desc = "Down";
    }
    {
      action = "v:count == 0 ? 'gk' : 'k'";
      key = "k";
      mode = [
        "n"
        "x"
      ];
      expr = true;
      desc = "Up";
    }
    {
      action = "v:count == 0 ? 'gk' : 'k'";
      key = "<Up>";
      mode = [
        "n"
        "x"
      ];
      expr = true;
      desc = "Up";
    }
    # Move to window using the <ctrl> hjkl keys
    {
      action = "<C-w>h";
      key = "<C-h>";
      mode = "n";
      desc = "Go to Left Window";
      noremap = false;
    }
    {
      action = "<C-w>j";
      key = "<C-j>";
      mode = "n";
      desc = "Go to Lower Window";
      noremap = false;
    }
    {
      action = "<C-w>k";
      key = "<C-k>";
      mode = "n";
      desc = "Go to Upper Window";
      noremap = false;
    }
    {
      action = "<C-w>l";
      key = "<C-l>";
      mode = "n";
      desc = "Go to Right Window";
      noremap = false;
    }
    # Resize window using <ctrl> arrow keys
    {
      action = "<cmd>resize +2<cr>";
      key = "<C-Up>";
      mode = "n";
      desc = "Increase Window Height";
    }
    {
      action = "<cmd>resize -2<cr>";
      key = "<C-Down>";
      mode = "n";
      desc = "Decrease Window Height";
    }
    {
      action = "<cmd>vertical resize -2<cr>";
      key = "<C-Left>";
      mode = "n";
      desc = "Decrease Window Width";
    }
    {
      action = "<cmd>vertical resize +2<cr>";
      key = "<C-Right>";
      mode = "n";
      desc = "Increase Window Width";
    }
    # Move Lines
    {
      action = "<cmd>execute 'move .+' . v:count1<cr>==";
      key = "<A-j>";
      mode = "n";
      desc = "Move Down";
    }
    {
      action = "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==";
      key = "<A-k>";
      mode = "n";
      desc = "Move Up";
    }
    {
      action = "<esc><cmd>m .+1<cr>==gi";
      key = "<A-j>";
      mode = "i";
      desc = "Move Down";
    }
    {
      action = "<esc><cmd>m .-2<cr>==gi";
      key = "<A-k>";
      mode = "i";
      desc = "Move Up";
    }
    {
      action = ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv";
      key = "<A-j>";
      mode = "v";
      desc = "Move Down";
    }
    {
      action = ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv";
      key = "<A-k>";
      mode = "v";
      desc = "Move Up";
    }
    # Buffers
    /*
      {
        action = "<cmd>bprevious<cr>";
        key = "<S-h>";
        mode = "n";
        desc = "Prev Buffer";
      }
      {
        action = "<cmd>bnext<cr>";
        key = "<S-l>";
        mode = "n";
        desc = "Next Buffer";
      }
      {
        action = "<cmd>bprevious<cr>";
        key = "[b";
        mode = "n";
        desc = "Prev Buffer";
      }
      {
        action = "<cmd>bnext<cr>";
        key = "]b";
        mode = "n";
        desc = "Next Buffer";
      }
    */
    {
      action = "<cmd>e #<cr>";
      key = "<leader>bb";
      mode = "n";
      desc = "Switch to Other Buffer";
    }
    {
      action = "<cmd>e #<cr>";
      key = "<leader>`";
      mode = "n";
      desc = "Switch to Other Buffer";
    }
    {
      action = ''function() require("snacks").bufdelete() end'';
      key = "<leader>bd";
      mode = "n";
      lua = true;
      desc = "Delete Buffer";
    }
    {
      action = ''function() require("snacks").bufdelete.other() end'';
      key = "<leader>bo";
      mode = "n";
      lua = true;
      desc = "Delete Other Buffers";
    }
    {
      action = "<cmd>:bd<cr>";
      key = "<leader>bD";
      mode = "n";
      desc = "Delete Buffer and Window";
    }
    # Clear search, diff update and redraw
    # taken from runtime/lua/_editor.lua
    {
      action = "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>";
      key = "<leader>ur";
      mode = "n";
      desc = "Redraw / Clear hlsearch / Diff Update";
    }
    # https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
    {
      action = "'Nn'[v:searchforward].'zv'";
      key = "n";
      mode = "n";
      expr = true;
      desc = "Next Search Result";
    }
    {
      action = "'Nn'[v:searchforward]";
      key = "n";
      mode = "x";
      expr = true;
      desc = "Next Search Result";
    }
    {
      action = "'Nn'[v:searchforward]";
      key = "n";
      mode = "o";
      expr = true;
      desc = "Next Search Result";
    }
    {
      action = "'nN'[v:searchforward].'zv'";
      key = "N";
      mode = "n";
      expr = true;
      desc = "Prev Search Result";
    }
    {
      action = "'nN'[v:searchforward]";
      key = "N";
      mode = "x";
      expr = true;
      desc = "Prev Search Result";
    }
    {
      action = "'nN'[v:searchforward]";
      key = "N";
      mode = "o";
      expr = true;
      desc = "Prev Search Result";
    }
    # Add undo break-points
    {
      action = ",<c-g>u";
      key = ",";
      mode = "i";
    }
    {
      action = ".<c-g>u";
      key = ".";
      mode = "i";
    }
    {
      action = ";<c-g>u";
      key = ";";
      mode = "i";
    }
    # Save file
    {
      action = "<cmd>w<cr><esc>";
      key = "<C-s>";
      mode = [
        "i"
        "x"
        "n"
        "s"
      ];
      desc = "Save File";
    }
    # Keywordprg
    {
      action = "<cmd>norm! K<cr>";
      key = "<leader>K";
      mode = "n";
      desc = "Keywordprg";
    }
    # Better indenting
    {
      action = "<gv";
      key = "<";
      mode = "v";
      desc = "Indent Left";
    }
    {
      action = ">gv";
      key = ">";
      mode = "v";
      desc = "Indent Right";
    }
    # Commenting
    {
      action = "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
      key = "gco";
      mode = "n";
      desc = "Add Comment Below";
    }
    {
      action = "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
      key = "gcO";
      mode = "n";
      desc = "Add Comment Above";
    }
    # Formatting
    {
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
    }
    # Diagnostics
    {
      action = ''<cmd>vim.diagnostic.open_float<CR>'';
      key = "<leader>cd";
      mode = "n";
      desc = "Line Diagnostics";
    }
    {
      action = ''<cmd>vim.diagnostic.goto_next()<CR>'';
      key = "]d";
      mode = "n";
      desc = "Next Diagnostic";
    }
    {
      action = ''<cmd>vim.diagnostic.goto_prev()<CR>'';
      key = "[d";
      mode = "n";
      desc = "Prev Diagnostic";
    }
    {
      action = ''<cmd>vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>'';
      key = "]e";
      mode = "n";
      desc = "Next Error";
    }
    {
      action = ''<cmd>vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>'';
      key = "[e";
      mode = "n";
      desc = "Prev Error";
    }
    {
      action = ''<cmd>vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })<CR>'';
      key = "]w";
      mode = "n";
      desc = "Next Warning";
    }
    {
      action = ''<cmd>vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })<CR>'';
      key = "[w";
      mode = "n";
      desc = "Prev Warning";
    }
    # Lazygit
    {
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
    }
    {
      action = ''function() require("snacks").lazygit() end'';
      key = "<leader>gG";
      mode = "n";
      lua = true;
      desc = "Lazygit (cwd)";
    }
    {
      action = ''function() require("snacks").picker.git_log_file() end'';
      key = "<leader>gf";
      mode = "n";
      lua = true;
      desc = "Git Current File History";
    }
    {
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
    }
    {
      action = ''function() require("snacks").picker.git_log() end'';
      key = "<leader>gL";
      mode = "n";
      lua = true;
      desc = "Git Log (cwd)";
    }
    # Git
    {
      action = ''function() require("snacks").picker.git_log_line() end'';
      key = "<leader>gb";
      mode = "n";
      lua = true;
      desc = "Git Blame Line";
    }
    {
      action = ''function() require("snacks").gitbrowse() end'';
      key = "<leader>gB";
      mode = [
        "n"
        "x"
      ];
      lua = true;
      desc = "Git Browse (open)";
    }
    {
      action = ''function() require("snacks").gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false }) end'';
      key = "<leader>gY";
      mode = [
        "n"
        "x"
      ];
      lua = true;
      desc = "Git Browse (copy)";
    }
    {
      action = ''function() require("snacks").scratch() end'';
      key = "<leader>.";
      lua = true;
      mode = "n";
      desc = "Toggle Scratch Buffer";
    }
    {
      action = ''function() require("snacks").scratch.select() end'';
      key = "<leader>S";
      lua = true;
      mode = "n";
      desc = "Select Scratch Buffer";
    }
    {
      action = ''function() require("snacks").profiler.scratch() end'';
      key = "<leader>dps";
      lua = true;
      mode = "n";
      desc = "Profiler Scratch Buffer";
    }
    {
      key = "<leader>hs";
      mode = "n";
      action = ''
        function()
          require("snacks").health.check()
        end
      '';
      desc = "Snacks Health Check";
      lua = true;
    }
    # Noice
    {
      key = "<S-Enter>";
      action = ''
        function()
          require("noice").redirect(vim.fn.getcmdline())
        end
      '';
      mode = "c";
      desc = "Redirect Cmdline";
      lua = true;
    }
    {
      key = "<leader>snl";
      action = ''
        function()
          require("noice").cmd("last")
        end
      '';
      mode = "n";
      desc = "Noice Last Message";
      lua = true;
    }
    {
      key = "<leader>snh";
      action = ''
        function()
          require("noice").cmd("history")
        end
      '';
      mode = "n";
      desc = "Noice History";
      lua = true;
    }
    {
      key = "<leader>sna";
      action = ''
        function()
          require("noice").cmd("all")
        end
      '';
      mode = "n";
      desc = "Noice All";
      lua = true;
    }
    {
      key = "<leader>snd";
      action = ''
        function()
          require("noice").cmd("dismiss")
        end
      '';
      mode = "n";
      desc = "Dismiss All";
      lua = true;
    }
    {
      key = "<leader>snt";
      action = ''
        function()
          require("noice").cmd("pick")
        end
      '';
      mode = "n";
      desc = "Noice Picker (Telescope/FzfLua)";
      lua = true;
    }
    {
      key = "<c-f>";
      action = ''
        function()
          if not require("noice.lsp").scroll(4) then
            return "<c-f>"
          end
        end
      '';
      mode = [
        "i"
        "n"
        "s"
      ];
      silent = true;
      expr = true;
      desc = "Scroll Forward";
      lua = true;
    }
    {
      key = "<c-b>";
      action = ''
        function()
          if not require("noice.lsp").scroll(-4) then
            return "<c-b>"
          end
        end
      '';
      mode = [
        "i"
        "n"
        "s"
      ];
      silent = true;
      expr = true;
      desc = "Scroll Backward";
      lua = true;
    }
  ];
  programs.nvf.settings.vim.lazy.plugins = {
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
}
