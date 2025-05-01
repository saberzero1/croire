{ flake, pkgs, ... }:
{
  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML "${flake.inputs.dotfiles}/starship/starship.toml";
    enableZshIntegration = true;
    enableBashIntegration = true;
  };
}
