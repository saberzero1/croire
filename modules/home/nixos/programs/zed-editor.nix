{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  programs.zed-editor = {
    enable = false;
    package = pkgs.zed-editor-fhs;
    extraPackages = with pkgs; [
      nodejs_latest
      nixd
      jq
    ];
    extensions = [
      "awk"
      "csharp"
      "csv"
      "cython"
      "discord-presence"
      "docker-compose"
      "dockerfile"
      "ejs"
      "elixir"
      "env"
      "erlang"
      "ini"
      "java"
      "just"
      "libsql-context-server"
      "live-server"
      "lua"
      "make"
      "nix"
      "python"
      "python-requirements"
      "scss"
      "sql"
      "ssh-config"
      "tmux"
      "tokyo-night"
      "tree-sitter-query"
      "vscode-icons"
      "xml"
      "zig"
    ];
    userKeymaps = pkgs.lib.importJSON "${self}/programs/zed/keymap.json";
    userSettings = pkgs.lib.importJSON "${self}/programs/zed/settings.json";
  };
}
