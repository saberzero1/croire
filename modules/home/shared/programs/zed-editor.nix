{ flake, pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    extraPackages = with pkgs; [
      nixd
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
    userKeymaps = pkgs.lib.importJSON "${flake.inputs.dotfiles}/zed/keymap.json";
    userSettings = pkgs.lib.importJSON "${flake.inputs.dotfiles}/zed/settings.json";
  };
}
