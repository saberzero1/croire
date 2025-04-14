{ pkgs, ... }:
{
  launchd = {
    user = {
      agents = {
        rclone-mounts = {
          command = "${pkgs.rclone}/bin/rclone mount hidrive:hidrive ~/hidrive";
          serviceConfig = {
            RunAtLoad = true;
            KeepAlive = true;
            StandardOutPath = "/tmp/logs/rclone/rclone-mounts.log";
            StandardErrorPath = "/tmp/logs/rclone/rclone-mounts.log";
          };
        };
      };
    };
  };
}
