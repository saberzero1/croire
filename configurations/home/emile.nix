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
  home = {
    username = "emile";
    homeDirectory = lib.mkDefault "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/emile";
    stateVersion = "24.11";
  };
}
