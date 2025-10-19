{ flake, config, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    flake.inputs.nix-doom-emacs-unstraightened.hmModule
  ];
  programs.doom-emacs = {
    enable = true;
    doomDir = "${self}/programs/doom-emacs";
    doomLocalDir = "${config.home.homeDirectory}/doom.d";
    provideEmacs = true;
  };
}
