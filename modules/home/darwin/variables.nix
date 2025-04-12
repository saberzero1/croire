{ ... }:
{
  home = {
    shellAliases = {
      "reload-rclone" = "launchd --user restart rCloneMounts.service";
    };
    sessionVariables = { };
  };
}
