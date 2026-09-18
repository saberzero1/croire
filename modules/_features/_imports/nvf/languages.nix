# NVF Language Configurations
#
# Scoped to languages that actually appear in the repos on this machine, plus a
# small set of low-friction "likely next" ones (rust, go, sql, clang). The
# previous 45-language set installed 35 LSP servers, ~22 of them for languages
# with zero files on disk -- which dragged in GHC, two JVM servers, two dotnet
# servers, BEAM and LLVM for nothing.
#
# Grammars are NOT listed here or in treesitter.nix; each module below brings
# its own via `treesitter.enable`.
{ pkgs, ... }:
let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in
{
  programs.nvf.settings.vim.languages = {
    # Global settings
    enableDAP = true;
    enableExtraDiagnostics = true;
    enableFormat = true;
    enableTreesitter = true;

    # =========================================
    # Web / frontend
    # =========================================
    typescript = {
      enable = true;
      extraDiagnostics = {
        enable = true;
        types = [ "eslint_d" ];
      };
      format = {
        enable = true;
        type = [ "prettier" ];
      };
      lsp = {
        enable = true;
        servers = [ "typescript-language-server" ];
      };
      treesitter.enable = true;
    };

    tsx = {
      enable = true;
      lsp = {
        enable = true;
        servers = [ "typescript-language-server" ];
      };
      treesitter.enable = true;
    };

    svelte = {
      enable = true;
      extraDiagnostics = {
        enable = true;
        types = [ "eslint_d" ];
      };
      format = {
        enable = true;
        type = [ "prettier" ];
      };
      lsp = {
        enable = true;
        servers = [ "svelte-language-server" ];
      };
      treesitter.enable = true;
    };

    html = {
      enable = true;
      treesitter = {
        enable = true;
        autotagHtml = true;
      };
      lsp = {
        enable = true;
        servers = [ "emmet-ls" ];
      };
    };

    css = {
      enable = true;
      format = {
        enable = true;
        type = [ "prettier" ];
      };
      lsp = {
        enable = true;
        servers = [ "vscode-css-language-server" ];
      };
      treesitter.enable = true;
    };

    scss = {
      enable = true;
      format = {
        enable = true;
        type = [ "prettier" ];
      };
      lsp = {
        enable = true;
        servers = [ "some-sass-language-server" ];
      };
      treesitter.enable = true;
    };

    # =========================================
    # Data / config formats
    # =========================================
    json = {
      enable = true;
      format = {
        enable = true;
        type = [ "prettier" ];
      };
      lsp = {
        enable = true;
        servers = [ "vscode-json-language-server" ];
      };
      treesitter.enable = true;
    };

    # json5 has no language server upstream -- treesitter + formatter only.
    json5 = {
      enable = true;
      format = {
        enable = true;
        type = [ "prettier" ];
      };
      treesitter.enable = true;
    };

    toml = {
      enable = true;
      format = {
        enable = true;
        type = [ "taplo" ];
      };
      lsp = {
        enable = true;
        servers = [ "taplo" ];
      };
      treesitter.enable = true;
    };

    yaml = {
      enable = true;
      lsp = {
        enable = true;
        servers = [ "yaml-language-server" ];
      };
      treesitter.enable = true;
    };

    # Markdown: marksman depends on dotnet (broken on Darwin)
    markdown = {
      enable = true;
      extraDiagnostics = {
        enable = true;
        types = [ "markdownlint-cli2" ];
      };
      format = {
        enable = true;
        type = [ "prettier" ];
      };
      lsp = {
        enable = !isDarwin;
        servers = [ "marksman" ];
      };
      treesitter.enable = true;
    };

    # =========================================
    # Shells
    # =========================================
    bash = {
      enable = true;
      extraDiagnostics = {
        enable = true;
        types = [ "shellcheck" ];
      };
      format = {
        enable = true;
        type = [ "shfmt" ];
      };
      lsp = {
        enable = true;
        servers = [ "bash-language-server" ];
      };
      treesitter.enable = true;
    };

    fish = {
      enable = true;
      format = {
        enable = true;
        type = [ "fish-indent" ];
      };
      lsp = {
        enable = true;
        servers = [ "fish-lsp" ];
      };
      treesitter.enable = true;
    };

    zsh = {
      enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };

    # =========================================
    # Nix (this repo)
    # =========================================
    nix = {
      enable = true;
      extraDiagnostics = {
        enable = true;
        types = [
          "deadnix"
          "statix"
        ];
      };
      format = {
        enable = true;
        type = [ "nixfmt" ];
      };
      lsp = {
        enable = true;
        servers = [ "nixd" ];
      };
      treesitter.enable = true;
    };

    # =========================================
    # Scripting / systems
    # =========================================
    lua = {
      enable = true;
      extraDiagnostics = {
        enable = true;
        types = [ "luacheck" ];
      };
      format = {
        enable = true;
        type = [ "stylua" ];
      };
      lsp.enable = true;
      treesitter.enable = true;
    };

    python = {
      enable = true;
      dap = {
        enable = true;
        debugger = [ "debugpy" ];
      };
      format = {
        enable = true;
        type = [ "black" ];
      };
      lsp = {
        enable = true;
        servers = [ "basedpyright" ];
      };
      treesitter.enable = true;
    };

    rust = {
      enable = true;
      extensions.crates-nvim.enable = true;
      dap.enable = true;
      format = {
        enable = true;
        type = [ "rustfmt" ];
      };
      lsp = {
        enable = true;
        servers = [ "rust-analyzer" ];
      };
      treesitter.enable = true;
    };

    go = {
      enable = true;
      dap = {
        enable = true;
        debugger = "delve";
      };
      format = {
        enable = true;
        type = [ "gofmt" ];
      };
      lsp = {
        enable = true;
        servers = [ "gopls" ];
      };
      treesitter.enable = true;
    };

    clang = {
      enable = true;
      cHeader = true;
      dap = {
        enable = true;
        debugger = [ "lldb" ];
      };
      lsp = {
        enable = true;
        servers = [ "clangd" ];
      };
      treesitter.enable = true;
    };

    sql = {
      enable = true;
      extraDiagnostics = {
        enable = true;
        types = [ "sqlfluff" ];
      };
      format = {
        enable = true;
        type = [ "sqlfluff" ];
      };
      lsp = {
        enable = true;
        servers = [ "sqls" ];
      };
      treesitter.enable = true;
    };

    # =========================================
    # Parked
    # =========================================
    # R disabled: upstream nixpkgs bug -- r-ps has a disallowed reference to
    # gcc-15.3.0. Config kept intact so this is a one-line flip once fixed.
    r = {
      enable = false;
      format = {
        enable = true;
        type = [ "format-r" ];
      };
      lsp = {
        enable = true;
        servers = [ "r-languageserver" ];
      };
      treesitter.enable = true;
    };
  };
}
