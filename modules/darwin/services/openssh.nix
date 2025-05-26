{ pkgs, ... }:
let
  primaryUserHome = "/Users/emile";
  workConfig =
    if builtins.pathExists "${primaryUserHome}/.ssh/config_work" then
      pkgs.lib.readFile "${primaryUserHome}/.ssh/config_work"
    else
      "";
in
{
  services.openssh = {
    enable = true;
    extraConfig =
      ''
        Host *
            IgnoreUnknown UseKeychain
            UseKeychain yes

        Host github.com
            AddKeysToAgent yes
            UseKeychain yes
            IdentityFile ~/.ssh/saberzero1-github

      ''
      + workConfig;
  };
}
