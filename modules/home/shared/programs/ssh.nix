{ pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin isLinux;
  extraInclude = if isDarwin then [ "config_work" ] else [ ];
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
    enableDefaultConfig = false;
    package = sshPackage;
    includes = extraInclude;
    extraOptionOverrides = {
      "IgnoreUnknown" = "UseKeychain";
    };
    matchBlocks = {
      "*" = {
        forwardAgent = false;
        addKeysToAgent = "ask";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
        extraOptions = {
          "UseKeychain" = "yes";
          "StrictHostKeyChecking" = "ask";
        };
      };
      "github.com" = {
        addKeysToAgent = "yes";
        identityFile = "~/.ssh/saberzero1-github";
        identitiesOnly = true;
        extraOptions = {
          "UseKeychain" = "yes";
        };
      };
    };
  };
}
