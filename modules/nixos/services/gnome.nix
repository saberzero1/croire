{ ... }:
{
  services.gnome = {
    gnome-browser-connector = {
      enable = true;
    };
    gnome-keyring = {
      enable = true;
    };
    gcr-ssh-agent = {
      enable = false;
    };
  };
}
