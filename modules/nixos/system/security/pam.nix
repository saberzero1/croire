{ ... }:
{
  security.pam = {
    services = {
      swaylock = {
        enableGnomeKeyring = true;
        gnupg.enable = true;
      };
      login = {
        enableGnomeKeyring = true;
        gnupg.enable = true;
      };
    };
  };
}
