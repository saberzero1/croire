{ flake, ... }:
{
  imports = [
    flake.inputs.geforce-infinity.homeManagerModules.default
  ];

  programs.geforce-infinity = {
    enable = true;
    settings = {
      resolution = {
        width = 2560;
        height = 1440;
      };
      fps = 120;
      accentColor = "#663399"; # RebeccaPurple
      rpcEnabled = false;
      notify = false;
    };
  };
}
