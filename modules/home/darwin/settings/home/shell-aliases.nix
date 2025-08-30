{ ... }:
{
  home.shellAliases = {
    "reload-rclone" = "launchd --user restart rCloneMounts.service";
    uuid = "uuidgen | tr -d '\n' | tr '[:upper:]' '[:lower:]' | pbcopy && pbpaste && echo"; # Generate UUID, copy to clipboard, and print
  };
}
