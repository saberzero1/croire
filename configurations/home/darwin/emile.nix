{ flake
, ...
}:
{
  imports = [
    flake.inputs.self.homeModules.default
    flake.inputs.self.homeModules.darwin-only
  ];
  home = {
    username = "emile";
    stateVersion = "24.11";
  };
}
