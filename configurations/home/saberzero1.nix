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
    self.homeModules.nixos
  ];
  home = {
    username = "saberzero1";
    stateVersion = "24.11";
  };

}
