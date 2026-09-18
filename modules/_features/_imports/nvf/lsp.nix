{
  programs.nvf.settings.vim.lsp = {
    enable = true;
    formatOnSave = true;
    inlayHints.enable = true;
    # lightbulb dropped: fastaction provides the code-action picker and the
    # gutter sign competed with gitsigns/diagnostics for the signcolumn.
    lspconfig = {
      enable = true;
      sources = { };
    };
    otter-nvim = {
      enable = true;
      mappings.toggle = "<leader>co"; # was <leader>lo
      setupOpts = {
        handle_leading_whitespace = true;
        diagnostic_update_event = [
          "BufWritePost"
          "InsertLeave"
        ];
      };
    };

    # nvf binds 20 buffer-local LSP keys under <leader>l*. That group had no
    # which-key label (it rendered as a bare "+12 keymaps"), and 13 of the 20
    # duplicated keys this config already defines elsewhere.
    #
    # Resolution: null the duplicates, and fold the genuinely useful ones into
    # the existing <leader>c "code" group / the g* goto family, so there is one
    # scheme instead of two. Note codeAction and renameSymbol were the only
    # bindings for those operations anywhere in the config -- dropping <leader>l
    # wholesale would have silently removed rename and code-action.
    mappings = {
      # -- nulled: already bound elsewhere --------------------------------
      goToDefinition = null; # gd            (Telescope lsp_definitions)
      listReferences = null; # gr            (Telescope lsp_references)
      listImplementations = null; # gI            (Telescope lsp_implementations)
      goToType = null; # gy            (Telescope lsp_typedefs)
      nextDiagnostic = null; # ]d            (keymaps.nix)
      previousDiagnostic = null; # [d            (keymaps.nix)
      openDiagnosticFloat = null; # <leader>cd    (keymaps.nix)
      format = null; # <leader>cf    (keymaps.nix)
      listDocumentSymbols = null; # <leader>ss    (Telescope) / <leader>cs (Trouble)
      listWorkspaceSymbols = null; # <leader>sS    (Telescope)
      hover = null; # K             (Neovim 0.11+ default LSP hover)
      signatureHelp = null; # noice signature.auto_open is enabled
      documentHighlight = null; # vim-illuminate highlights references automatically

      # -- rehomed into the existing scheme -------------------------------
      codeAction = "<leader>ca"; # was <leader>la  (only code-action binding)
      renameSymbol = "<leader>cr"; # was <leader>ln  (only rename binding)
      toggleFormatOnSave = "<leader>cF"; # was <leader>ltf
      goToDeclaration = "gD"; # was <leader>lgD (joins gd/gr/gI/gy)
      addWorkspaceFolder = "<leader>cwa"; # was <leader>lwa
      removeWorkspaceFolder = "<leader>cwr"; # was <leader>lwr
      listWorkspaceFolders = "<leader>cwl"; # was <leader>lwl
    };
    # trouble is declared as a lazy plugin in diagnostics.nix, which owns its
    # setupOpts and the <leader>x* keymaps. Enabling it here too would install a
    # second copy and double-call require("trouble").setup().
    presets = {
      tailwindcss-language-server.enable = true;
    };
    servers = {
      "*" = {
        root_markers = [
          ".git"
          "flake.nix"
        ];
        capabilities = {
          textDocument = {
            multilineTokenSupport = true;
          };
        };
      };
    };
  };
}
