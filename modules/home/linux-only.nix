{ flake, ... }:
{
  imports = [
    flake.inputs.self.homeModules.croire-lib
    ./nixos
  ];
}
