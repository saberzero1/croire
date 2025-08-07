{ pkgs, ... }:
{
  imports =
    builtins.map (fn: ./${fn})
      (
        builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir ./.))
      )
    ++ [
      ./plugins
    ];
  programs.nixvim = {
    enable = true;
    enableMan = false;
    extraPackages = with pkgs; [
      fzf
      fd
      lazygit
      ripgrep
    ];
  };
}
