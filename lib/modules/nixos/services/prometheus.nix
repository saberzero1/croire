{ config, ... }:
{
  # Backups and Restores
  services.prometheus = {
    enable = false;
    exporters = {
      restic = {
        enable = false;
        port = 9753;
        rcloneConfigFile = "$HOME/.config/rclone/.rclone.conf";
      };
    };
  };
}
