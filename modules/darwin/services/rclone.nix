{ pkgs, ... }:
{
  launchd = {
    # Fixes "Too many open files" errors
    daemons."*".serviceConfig = {
      SoftResourceLimits.NumberOfFiles = 65536;
      HardResourceLimits.NumberOfFiles = 1048576;
    };
    agents."*".serviceConfig = {
      SoftResourceLimits.NumberOfFiles = 65536;
      HardResourceLimits.NumberOfFiles = 1048576;
    };
    user.agents = {
      "*".serviceConfig = {
        SoftResourceLimits.NumberOfFiles = 65536;
        HardResourceLimits.NumberOfFiles = 1048576;
      };
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
}
