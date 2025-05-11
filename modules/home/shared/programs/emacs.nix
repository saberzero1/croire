{ flake, ... }:
{
  programs.doom-emacs = {
    enable = true;
    doomDir = "${flake.inputs.dotfiles}/doom-emacs";
  };
}
