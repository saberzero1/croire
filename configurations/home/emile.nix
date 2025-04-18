{ flake
, ...
}:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.homeModules.shared
    self.homeModules.darwin
  ];
  home = {
    username = "emile";
    stateVersion = "24.11";
  };
}
