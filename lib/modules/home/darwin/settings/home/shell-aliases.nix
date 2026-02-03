{ pkgs, ... }:
{
  home.shellAliases = {
    "reload-rclone" = "launchctl kickstart -k gui/$(id -u)/rCloneMounts.service";
  };

  # Scripts that use shell-specific syntax (&&) are defined as proper scripts
  # to ensure compatibility with both zsh and nushell
  home.packages = [
    (pkgs.writeShellScriptBin "uuid" ''
      # Generate UUID, copy to clipboard, and print
      uuidgen | tr -d '\n' | tr '[:upper:]' '[:lower:]' | pbcopy && pbpaste && echo
    '')
  ];
}
