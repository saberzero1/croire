{ pkgs, ... }:
{
  home.shellAliases = {
    power-down = "shutdown --poweroff --no-wall 0";
  };

  # Scripts that use shell-specific syntax (&&) are defined as proper scripts
  # to ensure compatibility with both zsh and nushell
  home.packages = [
    (pkgs.writeShellScriptBin "uuid" ''
      # Generate UUID, copy to clipboard, and print
      uuidgen | tr -d '\n' | tr '[:upper:]' '[:lower:]' | wl-copy -n && wl-paste
    '')
  ];
}
