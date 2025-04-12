{ ... }:
{
  launchd = {
    user = {
      agents = {
        "rCloneMounts" = {
          command = "reload-rclone";
          environment = {
            "reload-rclone" = "launchd --user restart rCloneMounts.service";
          };
          serviceConfig = {
            runAtLoad = true;
            standardOutPath = "$HOME/.logs/rclone/rclone-mounts.log";
            standardErrorPath = "$HOME/.logs/rclone/rclone-mounts.log";
          };
        };
      };
    };
  };
}
