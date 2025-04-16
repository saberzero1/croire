{ pkgs, lib, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getExe pkgs.greetd.tuigreet} --remember --theme 'border=blue;text=cyan;prompt=green;time=red;action=blue;button=white;container=black;input=red' --cmd sway";
        user = "greeter";
      };
    };
  };

  users.users.greeter = { };
}
