{ flake
, pkgs
, lib
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
  home.username = "emile";
  home.homeDirectory = lib.mkDefault "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/emile";
  home.stateVersion = "24.05";
}
