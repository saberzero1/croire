{ ... }:
{
  home.shellAliases = {
    power-down = "shutdown --poweroff --no-wall 0";
    uuid = "uuidgen | tr -d '\\n' | tr '[:upper:]' '[:lower:]' | wl-copy -n && wl-paste"; # Generate UUID, copy to clipboard, and print
  };
}
