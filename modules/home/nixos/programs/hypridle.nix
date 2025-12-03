{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 36000; # 600 minutes
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 36030; # 600.5 minutes
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 72000; # 1200 minutes
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
