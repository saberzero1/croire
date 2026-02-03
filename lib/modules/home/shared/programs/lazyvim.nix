{ flake, pkgs, ... }:
{
  imports = [
    flake.inputs.lazyvim.homeManagerModules.default
    ./lazyvim
  ];

  programs.lazyvim = {
    enable = false;

    pluginSource = "latest";

    extraPackages = with pkgs; [
      curl
      fd
      fzf
      git
      lazygit
      ripgrep
    ];
  };
}
