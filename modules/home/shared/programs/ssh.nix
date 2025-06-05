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
  programs.ssh = {
    enable = true;
    package = pkgs.openssh;

    extraConfig =
      ''
        Host *
            IgnoreUnknown UseKeychain
            UseKeychain yes
            UserKnownHostsFile ~/.ssh/known_hosts
            StrictHostKeyChecking ask

        Host github.com
            AddKeysToAgent yes
            UseKeychain yes
            IdentityFile ~/.ssh/saberzero1-github

      ''
      + workConfig;
  };
}
