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
          timeout = 3600; # 60 minutes
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 3630; # 60.5 minutes
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 7200; # 120 minutes
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
