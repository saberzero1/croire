{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  programs.zed-editor = {
    enable = false;
    extraPackages = with pkgs; [
      nixd
      jq
    ];
    extensions = [
      "awk"
      "csharp"
      "csv"
      "discord-presence"
      "docker-compose"
      "dockerfile"
      "ejs"
      "elixir"
      "env"
      "erlang"
      "ini"
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
