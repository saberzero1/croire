{ config, ... }:
{
  services.prometheus = {
    enable = false;
    exporters = {
      restic = {
        enable = false;
        port = 9753;
        rcloneConfigFile = "${config.home.homeDirectory}/.config/rclone/.rclone.conf";
      };
    };
  };
}
