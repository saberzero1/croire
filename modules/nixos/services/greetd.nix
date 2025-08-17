{ pkgs, lib, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getExe pkgs.tuigreet} --time --remember --theme 'border=lightmagenta;text=lightcyan;prompt=lightgreen;time=lightred;action=lightblue;button=lightgray;container=darkgray;input=lightred' --greeting 'Welcome home' --cmd sway";
        user = "greeter";
      };
    };
  };

  users.users.greeter = { };
}
