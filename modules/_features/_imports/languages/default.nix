# Programming Language Toolchains - Consolidated
# Development packages for various programming languages
{ pkgs, lib, ... }:
{
  home = {
    packages =
      # =========================================
      # Nix
      # =========================================
      (with pkgs; [
        deadnix
        nixd
        nixpkgs-fmt
        nixfmt
        statix
      ])
      # =========================================
      # Go
      # =========================================
      ++ (with pkgs; [
        go
        gopls
        gofumpt
        goimports-reviser
        golint
        go-tools
        delve
      ])
      # =========================================
      # Rust
      # =========================================
      ++ (with pkgs; [ rustup ])
      # =========================================
      # Ruby
      # =========================================
      ++ (with pkgs; [ ruby ])
      # =========================================
      # Elixir
      # =========================================
      ++ (with pkgs; [
        elixir
        erlang
      ])
      # =========================================
      # JavaScript/TypeScript
      # =========================================
      ++ (with pkgs.nodePackages; [
        typescript
        prettier
        eslint_d
        svelte-language-server
        typescript-language-server
        # sass
        serve
        npm
        vscode-langservers-extracted
      ])
      ++ (with pkgs; [ bun ])
      # =========================================
      # Java
      # =========================================
      ++ (with pkgs; [
        maven
        gradle
        jdk
        jre
      ])
      # =========================================
      # Python
      # =========================================
      ++ (with pkgs.python3Packages; [
        pandas
        matplotlib
        seaborn
        pip
        scikit-learn
        numpy
        python-dotenv
        black
        pytest
        json5
        requests
        tkinter
        async-tkinter-loop
        customtkinter
        pexpect
      ])
      # =========================================
      # C# / .NET (Linux only - broken on Darwin)
      # =========================================
      ++ lib.optionals (!pkgs.stdenv.hostPlatform.isDarwin) (
        (with pkgs; [
          dotnet-sdk_9
          csharpier
          mono
        ])
        ++ (with pkgs.dotnetPackages; [ Nuget ])
      )
      # =========================================
      # Lua
      # =========================================
      ++ (with pkgs.lua53Packages; [
        libluv
        argparse
        busted
        busted-htest
        commons-nvim
        compat53
        cosmo
        ldoc
        http
        image-nvim
        inspect
        jsregexp
        lua-lsp
        lua-utils-nvim
        luacheck
        luafilesystem
        luarocks-nix
        luarocks-build-rust-mlua
        luarocks-build-treesitter-parser
        luasql-sqlite3
        luassert
        luasystem
        luatext
        luaunit
        luautf8
        luazip
        luv
        lyaml
        markdown
        mediator_lua
        middleclass
        neorg
        nlua
        nui-nvim
        nvim-cmp
        nvim-nio
        pathlib-nvim
        penlight
        readline
        rest-nvim
        rtp-nvim
        say
        serpent
        std-_debug
        std-normalize
        stdlib
      ]);

    # =========================================
    # Java environment
    # =========================================
    sessionVariables = {
      JAVA_HOME = "${pkgs.jdk}/lib/openjdk";
    };
    shellAliases = {
      javac = "${pkgs.jdk}/bin/javac";
      java = "${pkgs.jdk}/bin/java";
    };
  };
}
