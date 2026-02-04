# LazyVim Language Configurations - Consolidated
# All language configurations for LazyVim extras
{ lib, pkgs, ... }:
let
  grammarPlugins = builtins.attrValues pkgs.vimPlugins.nvim-treesitter.grammarPlugins;
  grammarPackages = builtins.attrValues pkgs.tree-sitter-grammars;
  filterNonPackage = builtins.filter lib.isDerivation;
  filterBroken = builtins.filter (n: !n.meta.broken);
  filterEmpty = builtins.filter (n: n.pname or "" != "");
  allGrammarPlugins = filterEmpty (filterBroken (filterNonPackage grammarPlugins));
  allGrammarPackages = filterEmpty (filterBroken (filterNonPackage grammarPackages));
in
{
  programs.lazyvim = {
    extras = {
      lang = {
        # =========================================
        # Enabled languages
        # =========================================
        docker = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };

        elixir = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };

        elm = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };

        erlang = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };

        git = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };

        go = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };

        json = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };

        markdown = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };

        nix = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };

        python = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };

        ruby = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };

        rust = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };

        svelte = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };

        toml = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };

        typescript = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };

        yaml = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };

        # =========================================
        # Disabled languages
        # =========================================
        java = {
          enable = false;
          installDependencies = true;
          installRuntimeDependencies = true;
        };
      };
    };

    # =========================================
    # Extra packages for language support
    # =========================================
    extraPackages =
      with pkgs;
      [
        # Tree-sitter
        tree-sitter

        # Docker
        hadolint

        # Elixir
        elixir
        elixir-ls

        # Elm
        elmPackages.elm-format

        # Erlang
        erlang

        # Git
        git

        # Go
        go
        go-tools
        gopls
        delve

        # JSON
        jq

        # Markdown
        pandoc
        prettier
        markdownlint-cli
        markdownlint-cli2

        # Nix
        nixd
        nixpkgs-fmt
        alejandra

        # Python
        pyright

        # Ruby
        ruby

        # Rust
        bacon
        cargo
        clippy
        rust-analyzer
        rustfmt
        rustup

        # Svelte
        svelte-language-server

        # TypeScript/JavaScript
        nodejs_latest
        yarn
        typescript
        deno
        eslint_d
        eslint
        bun

        # YAML
        yamllint
        yq

        # Java (disabled but packages available)
        jdk
        maven
        gradle
      ]
      ++ (with pkgs.vimPlugins; [
        # Markdown plugins
        vim-markdown-toc
      ])
      ++ allGrammarPackages
      ++ allGrammarPlugins;
  };
}
