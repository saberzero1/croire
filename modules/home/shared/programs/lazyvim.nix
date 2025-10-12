{ flake, pkgs, ... }:
{
  imports = [
    flake.inputs.lazyvim.homeManagerModules.default
    ./lazyvim
  ];

  programs.lazyvim = {
    enable = true;

    extraPackages = with pkgs; [
      fd
      git
      lazygit
      ripgrep
    ];
  };
}
