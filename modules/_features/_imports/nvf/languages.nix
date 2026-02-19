# NVF Language Configurations - Consolidated
# All language configurations for neovim via NVF
{ pkgs, ... }:
let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in
{
  programs.nvf.settings.vim.languages = {
    # Global settings
    enableDAP = true;
    enableExtraDiagnostics = true;
    enableFormat = true;
    enableTreesitter = true;

    # =========================================
    # Simple languages (enable with defaults)
    # =========================================
    assembly = {
      enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };

    clojure = {
      enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };

    cue = {
      enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };

    helm = {
      enable = true;
      lsp = {
        enable = true;
        servers = [ "helm-ls" ];
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

    java = {
      enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };

    nu = {
      enable = true;
      lsp = {
        enable = true;
        servers = [ "nushell" ];
      };
      treesitter.enable = true;
    };

    odin = {
      enable = true;
      lsp = {
        enable = false; # ols broken: upstream uses disallowed `using` statements with newer Odin compiler
        servers = [ "ols" ];
      };
      treesitter.enable = true;
    };

    php = {
      enable = true;
      lsp = {
        enable = true;
        servers = [ "phpactor" ];
      };
      treesitter.enable = true;
    };

    tailwind = {
      enable = true;
      lsp = {
        enable = true;
        servers = [ "tailwindcss" ];
      };
    };

    terraform = {
      enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };

    wgsl = {
      enable = true;
      lsp = {
        enable = true;
        servers = [ "wgsl-analyzer" ];
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

    # =========================================
    # Languages with formatting
    # =========================================
    css = {
      enable = true;
      format = {
        enable = true;
        type = [ "prettier" ];
      };
      lsp = {
        enable = true;
        servers = [ "cssls" ];
      };
    };

    hcl = {
      enable = true;
      format = {
        enable = true;
        type = [ "hclfmt" ];
      };
      lsp.enable = true;
      treesitter.enable = true;
    };

    ocaml = {
      enable = true;
      format = {
        enable = true;
        type = [ "ocamlformat" ];
      };
      lsp = {
        enable = true;
        servers = [ "ocaml-lsp" ];
      };
      treesitter.enable = true;
    };

    r = {
      enable = true;
      format = {
        enable = true;
        type = [ "format_r" ];
      };
      lsp = {
        enable = true;
        servers = [ "r_language_server" ];
      };
      treesitter.enable = true;
    };

    typst = {
      enable = true;
      format = {
        enable = true;
        type = [ "typstyle" ];
      };
      lsp = {
        enable = true;
        servers = [ "tinymist" ];
      };
      treesitter.enable = true;
    };

    # =========================================
    # Languages with extra diagnostics
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
        servers = [ "bash-ls" ];
      };
      treesitter.enable = true;
    };

    kotlin = {
      enable = true;
      extraDiagnostics = {
        enable = true;
        types = [ "ktlint" ];
      };
      lsp.enable = true;
      treesitter.enable = true;
    };

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

    ruby = {
      enable = true;
      extraDiagnostics = {
        enable = true;
        types = [ "rubocop" ];
      };
      format = {
        enable = true;
        type = [ "rubocop" ];
      };
      lsp = {
        enable = true;
        servers = [ "solargraph" ];
      };
      treesitter.enable = true;
    };

    sql = {
      enable = true;
      dialect = "ansi";
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
        servers = [ "svelte" ];
      };
      treesitter.enable = true;
    };

    ts = {
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
        servers = [ "ts_ls" ];
      };
      treesitter.enable = true;
    };

    # =========================================
    # Languages with DAP (debugging)
    # =========================================
    clang = {
      enable = true;
      cHeader = true;
      dap = {
        enable = true;
        debugger = "lldb-vscode";
      };
      lsp = {
        enable = true;
        servers = [ "clangd" ];
      };
      treesitter.enable = true;
    };

    dart = {
      enable = true;
      dap.enable = true;
      flutter-tools.enable = true;
      lsp = {
        enable = true;
        servers = [ "dart" ];
      };
      treesitter.enable = true;
    };

    elixir = {
      enable = true;
      elixir-tools.enable = true;
      format = {
        enable = true;
        type = [ "mix" ];
      };
      lsp = {
        enable = true;
        servers = [ "elixirls" ];
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

    haskell = {
      enable = true;
      dap.enable = false; # currently broken
      lsp.enable = true;
      treesitter.enable = true;
    };

    python = {
      enable = true;
      dap = {
        enable = true;
        debugger = "debugpy";
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
        opts = ''
          ['rust-analyzer'] = {
            cargo = {allFeature = true},
            checkOnSave = true,
            procMacro = {
              enable = true,
            },
          },
        '';
      };
      treesitter.enable = true;
    };

    scala = {
      enable = true;
      dap.enable = true;
      fixShortmess = true;
      lsp.enable = true;
      treesitter.enable = true;
    };

    zig = {
      enable = true;
      dap = {
        enable = true;
        debugger = "lldb-vscode";
      };
      lsp = {
        enable = false;
        servers = [ "zls" ];
      };
      treesitter.enable = true;
    };

    # =========================================
    # Nix language
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
    # Platform-specific languages
    # =========================================

    # C#: omnisharp depends on dotnet (broken on Darwin)
    csharp = {
      enable = true;
      lsp = {
        enable = !isDarwin;
        servers = [ "omnisharp" ];
      };
      treesitter.enable = true;
    };

    # F#: fsautocomplete/fantomas depend on dotnet (broken on Darwin)
    fsharp = {
      enable = true;
      format = {
        enable = !isDarwin;
        type = [ "fantomas" ];
      };
      lsp = {
        enable = !isDarwin;
        servers = [ "fsautocomplete" ];
      };
      treesitter.enable = true;
    };

    # Julia: julials only works on Linux
    julia = {
      enable = false;
      lsp = {
        enable = isLinux;
        servers = [ "julials" ];
      };
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
        extraFiletypes = [ "mdx" ];
        type = [ "prettierd" ];
      };
      lsp = {
        enable = !isDarwin;
        servers = [ "marksman" ];
      };
      treesitter.enable = true;
    };

    # Nim: only works on Linux
    nim = {
      enable = isLinux;
      format = {
        enable = true;
        type = [ "nimpretty" ];
      };
      lsp = {
        enable = true;
        servers = [ "nimlsp" ];
      };
      treesitter.enable = true;
    };

    # =========================================
    # Disabled languages
    # =========================================
    astro = {
      enable = false;
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
        servers = [ "astro" ];
      };
      treesitter.enable = true;
    };

    vala = {
      enable = false;
      lsp = {
        enable = true;
        servers = [ "vala_ls" ];
      };
      treesitter.enable = true;
    };
  };
}
