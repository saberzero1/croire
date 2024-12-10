{ flake
, config
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
    self.homeModules.nixos
  ];
  home = {
    username = "saberzero1";
    homeDirectory = lib.mkDefault "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/saberzero1";
    stateVersion = "24.05";
  };

}
