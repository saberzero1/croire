# Pickers and file navigation.
#
# This file used to declare a `fzf-lua` lazy plugin whose keys were almost
# entirely `<cmd>Telescope ...<cr>` invocations -- so fzf-lua was installed and
# loaded while Telescope did all the work. fzf-lua is gone; these are plain
# Telescope keymaps now (nvf lazy-loads Telescope on its `Telescope` cmd, and
# `require('telescope.builtin')` callers are fine because the plugin is
# already loaded by the time a keymap fires).
#
# Telescope itself is enabled in navigation.nix. nvf's own telescope mappings
# are nulled below: they collided with these on <leader>fg and <leader>fr, and
# added 16 further keys (<leader>fh/fs/ft plus 13 <leader>fv*/<leader>fl*) that
# had no which-key group.
{
  programs.nvf.settings.vim.telescope.mappings = {
    findProjects = null;
    findFiles = null;
    liveGrep = null;
    buffers = null;
    helpTags = null;
    open = null;
    resume = null;
    gitFiles = null;
    gitCommits = null;
    gitBufferCommits = null;
    gitBranches = null;
    gitStatus = null;
    gitStash = null;
    lspDocumentSymbols = null;
    lspWorkspaceSymbols = null;
    lspReferences = null;
    lspImplementations = null;
    lspDefinitions = null;
    lspTypeDefinitions = null;
    diagnostics = null;
    treesitter = null;
  };

  programs.nvf.settings.vim.keymaps = [
    # ── Core pickers ──────────────────────────────────────────────────────────
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
      key = "<leader>\"";
      mode = [
        "n"
        "v"
      ];
      action = "<cmd>Telescope registers<cr>";
      desc = "Registers";
    }

    # ── Files ─────────────────────────────────────────────────────────────────
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

    # ── Git ───────────────────────────────────────────────────────────────────
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

    # ── Search ────────────────────────────────────────────────────────────────
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
      action = "<cmd>Telescope diagnostics bufnr=0<cr>";
      desc = "Document Diagnostics";
    }
    {
      key = "<leader>sD";
      mode = [
        "n"
        "v"
      ];
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
      key = "<leader>sm";
      mode = [
        "n"
        "v"
      ];
      action = "<cmd>Telescope marks<cr>";
      desc = "Jump to Mark";
    }
    {
      key = "<leader>sM";
      mode = [
        "n"
        "v"
      ];
      action = "<cmd>Telescope man_pages<cr>";
      desc = "Man Pages";
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
      key = "<leader>sR";
      mode = [
        "n"
        "v"
      ];
      action = "<cmd>Telescope resume<cr>";
      desc = "Resume";
    }
    {
      key = "<leader>ss";
      mode = [
        "n"
        "v"
      ];
      action = "<cmd>Telescope lsp_document_symbols<cr>";
      desc = "Goto Symbol";
    }
    {
      key = "<leader>sS";
      mode = [
        "n"
        "v"
      ];
      action = "<cmd>Telescope lsp_workspace_symbols<cr>";
      desc = "Goto Symbol (Workspace)";
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
    # todo-comments pickers (were fzf-lua backed; TodoTelescope ships with the
    # plugin and lazy-loads via its own cmd)
    {
      key = "<leader>st";
      mode = [
        "n"
        "v"
      ];
      action = "<cmd>TodoTelescope<cr>";
      desc = "Todo";
    }
    {
      key = "<leader>sT";
      mode = [
        "n"
        "v"
      ];
      action = "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>";
      desc = "Todo/Fix/Fixme";
    }

    # ── LSP navigation ────────────────────────────────────────────────────────
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
  ];

  # neo-tree dropped: it had no keybinding anywhere in the config, and it was
  # what pulled in the never-configured image.nvim. yazi is the file manager.
  programs.nvf.settings.vim.utility.yazi-nvim = {
    enable = true;
    mappings = {
      openYazi = "<leader>e";
      openYaziDir = "<leader>E";
    };
    setupOpts = {
      open_for_directories = true;
    };
  };
}
