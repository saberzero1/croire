{ lib, ... }:
let
  # https://nix.dev/manual/nix/2.28/language/syntax.html#functions
  mkAuGroup = name: {
    name = "nix_${name}";
    enable = true;
    clear = true;
  };
  mkAutoCommand =
    { event
    , group
    , callback ? null
    , command ? null
    , desc ? null
    , pattern ? null
    , once ? false
    , nested ? false
    ,
    }:
    # Ensure only one of callback or command is provided
      assert command != null -> callback == null;
      assert callback != null -> command == null;
      {
        enable = true;
        inherit event;
        group = "nix_${group}";
        callback = if callback != null then lib.mkLuaInline callback else callback;
        inherit command;
        inherit desc;
        inherit pattern;
        inherit once;
        inherit nested;
      };
in
{
  programs.nvf.settings.vim.augroups = [
    (mkAuGroup "checktime")
    (mkAuGroup "highlight_yank")
    (mkAuGroup "resize_splits")
    (mkAuGroup "last_loc")
    (mkAuGroup "close_with_q")
    (mkAuGroup "man_unlisted")
    (mkAuGroup "wrap_spell")
    (mkAuGroup "json_conceal")
    (mkAuGroup "auto_create_dir")
  ];
  programs.nvf.settings.vim.autocmds = [
    (mkAutoCommand {
      event = [
        "FocusGained"
        "TermClose"
        "TermLeave"
      ];
      group = "checktime";
      callback = ''
        function()
          if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
          end
        end
      '';
    })
    (mkAutoCommand {
      event = [ "TextYankPost" ];
      group = "highlight_yank";
      callback = ''
        function()
          (vim.hl or vim.highlight).on_yank()
        end
      '';
    })
    (mkAutoCommand {
      event = [ "VimResized" ];
      group = "resize_splits";
      callback = ''
        function()
          local current_tab = vim.fn.tabpagenr()
          vim.cmd("tabdo wincmd =")
          vim.cmd("tabnext " .. current_tab)
        end
      '';
    })
    (mkAutoCommand {
      event = [ "BufReadPost" ];
      group = "last_loc";
      callback = ''
        function(event)
          local exclude = { "gitcommit" }
          local buf = event.buf
          if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
            return
          end
          vim.b[buf].lazyvim_last_loc = true
          local mark = vim.api.nvim_buf_get_mark(buf, '"')
          local lcount = vim.api.nvim_buf_line_count(buf)
          if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
          end
        end
      '';
    })
    (mkAutoCommand {
      event = [ "FileType" ];
      group = "close_with_q";
      pattern = [
        "PlenaryTestPopup"
        "checkhealth"
        "dbout"
        "gitsigns-blame"
        "grug-far"
        "help"
        "lspinfo"
        "neotest-output"
        "neotest-output-panel"
        "neotest-summary"
        "notify"
        "qf"
        "spectre_panel"
        "startuptime"
        "tsplayground"
      ];
      callback = ''
        function(event)
          vim.bo[event.buf].buflisted = false
          vim.schedule(function()
            vim.keymap.set("n", "q", function()
              vim.cmd("close")
              pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
            end, {
              buffer = event.buf,
              silent = true,
              desc = "Quit buffer",
            })
          end)
        end
      '';
    })
    (mkAutoCommand {
      event = [ "FileType" ];
      group = "man_unlisted";
      pattern = [ "man" ];
      callback = ''
        function(event)
          vim.bo[event.buf].buflisted = false
        end
      '';
    })
    (mkAutoCommand {
      event = [ "FileType" ];
      group = "wrap_spell";
      pattern = [
        "text"
        "plaintex"
        "typst"
        "gitcommit"
        "markdown"
      ];
      callback = ''
        function(event)
          vim.opt_local.wrap = true
          vim.opt_local.spell = true
        end
      '';
    })
    (mkAutoCommand {
      event = [ "FileType" ];
      group = "json_conceal";
      pattern = [
        "json"
        "jsonc"
        "json5"
      ];
      callback = ''
        function()
          vim.opt_local.conceallevel = 0
        end
      '';
    })
    (mkAutoCommand {
      event = [ "BufWritePre" ];
      group = "auto_create_dir";
      callback = ''
        function(event)
          if event.match:match("^%w%w+:[\\/][\\/]") then
            return
          end
          local file = vim.uv.fs_realpath(event.match) or event.match
          vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
        end
      '';
    })
  ];
}
