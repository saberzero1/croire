{ flake, pkgs, ... }:
{
  imports = [
    flake.inputs.lazyvim.homeManagerModules.default
    ./lazyvim
  ];

  programs.lazyvim = {
    enable = true;

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
