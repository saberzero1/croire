{ flake, ... }:
{
  imports = [
    flake.inputs.nix-doom-emacs-unstraightened.hmModule
  ];

  programs.doom-emacs = {
    enable = true;
    doomDir = "${flake.inputs.dotfiles}/doom-emacs";
  };
}
