{ pkgs, ... }:
let
  primaryUserHome = "/Users/emile";
  workConfig =
    if builtins.pathExists "${primaryUserHome}/.ssh/config_work" then
      pkgs.lib.readFile "${primaryUserHome}/.ssh/config_work"
    else
      "";
  inherit (pkgs.stdenv) isDarwin isLinux;
  sshPackage =
    if isDarwin then
      null
    else if isLinux then
      pkgs.openssh
    else
      throw "Unsupported platform for SSH configuration";
in
{
  programs.ssh = {
    enable = true;
    package = sshPackage;
    addKeysToAgent = "ask";

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
