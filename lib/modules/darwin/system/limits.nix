# System resource limits configuration
# Sets maxfiles limit at boot via launchd to avoid needing ulimit in shell configs
{ ... }:
{
  launchd.daemons.limit-maxfiles = {
    serviceConfig = {
      Label = "limit.maxfiles";
      ProgramArguments = [
        "/bin/launchctl"
        "limit"
        "maxfiles"
        "65535"
        "65535"
      ];
      RunAtLoad = true;
    };
  };
}
