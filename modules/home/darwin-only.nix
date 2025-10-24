{ flake, pkgs, ... }:
{
  imports = [
    flake.inputs.self.homeModules.croire-lib
    ./darwin
  ];
}
