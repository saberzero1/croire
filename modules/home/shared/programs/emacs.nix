{ flake, config, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    flake.inputs.nix-doom-emacs-unstraightened.hmModule
  ];
  # https://github.com/marienz/nix-doom-emacs-unstraightened/blob/main/home-manager.nix
  programs = {
    doom-emacs = {
      enable = true;
      doomDir = "${self}/programs/doom";
      doomLocalDir = "${config.home.homeDirectory}/.config/doom";
      provideEmacs = false;
    };
    emacs = {
      enable = true;
    };
  };
}
