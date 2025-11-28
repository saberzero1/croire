{ flake
, ...
}:
{
  imports = [
    flake.inputs.self.homeModules.default
    flake.inputs.self.homeModules.linux-only
  ];

  home = {
    username = "saberzero1";
    stateVersion = "25.11";
  };
}
