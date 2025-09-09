{ ... }:
{
  programs.nvf.settings.vim = {
    lazy.plugins."fzf-lua" = {
      enabled = true;
      package = "fzf-lua";
      setupModule = "fzf-lua";
      setupOpts = {
        fzf_colors = true;
        fzf_opts = {
          "--no-scrollbar" = true;
        };
        formatter = "path.dirname_first";
        actions = {
          files = {
            "ctrl-t" = "function() require('trouble.sources.fzf').actions.open end";
          };
        };
        keymap = {
          fzf = {
            "ctrl-q" = "select-all+accept";
            "ctrl-u" = "half-page-up";
            "ctrl-d" = "half-page-down";
            "ctrl-x" = "jump";
            "ctrl-f" = "preview-page-down";
            "ctrl-b" = "preview-page-up";
          };
          builtin = {
            "<c-f>" = "preview-page-down";
            "<c-b>" = "preview-page-up";
          };
        };
      };
      keys = [
        {
          key = "<c-j>";
          mode = "t";
          nowait = true;
          action = "<c-j>";
          ft = [ "fzf" ];
        }
        {
          key = "<c-k>";
          mode = "t";
          nowait = true;
          action = "<c-k>";
          ft = [ "fzf" ];
        }
        {
          key = "<leader>,";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>";
          desc = "Switch Buffer";
        }
        {
          key = "<leader>/";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope live_grep<cr>";
          desc = "Grep (Root Dir)";
        }
        {
          key = "<leader>:";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope command_history<cr>";
          desc = "Command History";
        }
        {
          key = "<leader><space>";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope find_files<cr>";
          desc = "Find Files (Root Dir)";
        }
        {
          key = "<leader>fb";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>";
          desc = "Buffers";
        }
        {
          key = "<leader>fc";
          mode = [
            "n"
            "v"
          ];
          action = "function() require('telescope.builtin').find_files({ cwd = '~/Repos/croire' }) end";
          desc = "Find Config File";
          lua = true;
        }
        {
          key = "<leader>ff";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope find_files<cr>";
          desc = "Find Files (Root Dir)";
        }
        {
          key = "<leader>fF";
          mode = [
            "n"
            "v"
          ];
          action = "function() require('telescope.builtin').find_files({ cwd = vim.fn.expand('%:h') }) end";
          desc = "Find Files (cwd)";
          lua = true;
        }
        {
          key = "<leader>fg";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope git_files<cr>";
          desc = "Find Files (git-files)";
        }
        {
          key = "<leader>fr";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope oldfiles<cr>";
          desc = "Recent";
        }
        {
          key = "<leader>fR";
          mode = [
            "n"
            "v"
          ];
          action = "function() require('telescope.builtin').oldfiles({ cwd = vim.fn.expand('%:h') }) end";
          desc = "Recent (cwd)";
          lua = true;
        }
        {
          key = "<leader>gc";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope git_commits<CR>";
          desc = "Commits";
        }
        {
          key = "<leader>gs";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope git_status<CR>";
          desc = "Status";
        }
        {
          key = "<leader>\"";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope registers<cr>";
          desc = "Registers";
        }
        {
          key = "<leader>sa";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope autocmds<cr>";
          desc = "Auto Commands";
        }
        {
          key = "<leader>sb";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope grep_curbuf<cr>";
          desc = "Buffer";
        }
        {
          key = "<leader>sc";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope command_history<cr>";
          desc = "Command History";
        }
        {
          key = "<leader>sC";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope commands<cr>";
          desc = "Commands";
        }
        {
          key = "<leader>sd";
          mode = [
            "n"
            "v"
          ];
          # action = "<cmd>Telescope diagnostics_document<cr>";
          action = "<cmd>Telescope diagnostics<cr>";
          desc = "Document Diagnostics";
        }
        {
          key = "<leader>sD";
          mode = [
            "n"
            "v"
          ];
          # action = "<cmd>Telescope diagnostics_workspace<cr>";
          action = "<cmd>Telescope diagnostics<cr>";
          desc = "Workspace Diagnostics";
        }
        {
          key = "<leader>sg";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope live_grep<cr>";
          desc = "Grep (Root Dir)";
        }
        {
          key = "<leader>sG";
          mode = [
            "n"
            "v"
          ];
          action = "function() require('telescope.builtin').live_grep({ cwd = vim.fn.expand('%:h') }) end";
          desc = "Grep (cwd)";
          lua = true;
        }
        {
          key = "<leader>sh";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope help_tags<cr>";
          desc = "Help Pages";
        }
        {
          key = "<leader>sH";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope highlights<cr>";
          desc = "Search Highlight Groups";
        }
        {
          key = "<leader>sj";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope jumplist<cr>";
          desc = "Jumplist";
        }
        {
          key = "<leader>sk";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope keymaps<cr>";
          desc = "Key Maps";
        }
        {
          key = "<leader>sl";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope loclist<cr>";
          desc = "Location List";
        }
        {
          key = "<leader>sM";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope man_pages<cr>";
          desc = "Location List";
        }
        {
          key = "<leader>sm";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope marks<cr>";
          desc = "Jump to Mark";
        }
        {
          key = "<leader>sR";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope resume<cr>";
          desc = "Resume";
        }
        {
          key = "<leader>sq";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope quickfix<cr>";
          desc = "Quickfix List";
        }
        {
          key = "<leader>sw";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope grep_string<cr>";
          desc = "Word (Root Dir)";
        }
        {
          key = "<leader>ss";
          mode = [
            "n"
            "v"
          ];
          # action = "function() require('fzf-lua').lsp_document_symbols({ regex_filter = symbols_filter, }) end";
          action = "<cmd>Telescope lsp_document_symbols<cr>";
          desc = "Goto Symbol";
          # lua = true;
        }
        {
          key = "<leader>sS";
          mode = [
            "n"
            "v"
          ];
          # action = "function() require('fzf-lua').lsp_live_workspace_symbols({ regex_filter = symbols_filter, }) end";
          action = "<cmd>Telescope lsp_workspace_symbols<cr>";
          desc = "Goto Symbol (Workspace)";
          # lua = true;
        }
        # nvim-lspconfig mappings
        {
          key = "gd";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope lsp_definitions jump1=true ignore_current_line=true<cr>";
          desc = "Goto Definition";
        }
        {
          key = "gr";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope lsp_references jump1=true ignore_current_line=true<cr>";
          desc = "References";
          nowait = true;
        }
        {
          key = "gI";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope lsp_implementations jump1=true ignore_current_line=true<cr>";
          desc = "Goto Implementation";
        }
        {
          key = "gy";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>Telescope lsp_typedefs jump1=true ignore_current_line=true<cr>";
          desc = "Goto T[y]pe Definition";
        }
        # todo-comments.nvim mappings
        {
          key = "<leader>st";
          mode = [
            "n"
            "v"
          ];
          action = "function() require('todo-comments.fzf').todo() end";
          desc = "Todo";
          lua = true;
        }
        {
          key = "<leader>sT";
          mode = [
            "n"
            "v"
          ];
          action = "function() require('todo-comments.fzf').todo({ keywords = { 'TODO', 'FIX', 'FIXME' } }) end";
          desc = "Todo/Fix/Fixme";
          lua = true;
        }
      ];
    };
    filetree.neo-tree = {
      enable = true;
    };
    utility.yazi-nvim = {
      enable = true;
      mappings = {
        openYazi = "<leader>e";
        openYaziDir = "<leader>E";
      };
      setupOpts = {
        open_for_directories = true;
      };
    };
  };
}
