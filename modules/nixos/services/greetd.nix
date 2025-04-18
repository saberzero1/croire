{ pkgs, lib, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getExe pkgs.greetd.tuigreet} --time --remember --theme 'border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=darkgray;input=red' --greeting 'Welcome home' --cmd sway";
        user = "greeter";
      };
    };
  };

  users.users.greeter = { };
}
