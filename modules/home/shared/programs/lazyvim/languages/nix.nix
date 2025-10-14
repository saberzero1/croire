{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.nix.enable = true;
    };

    extraPackages = with pkgs; [
      nixd
      nixpkgs-fmt
      alejandra
    ];
  };
}
