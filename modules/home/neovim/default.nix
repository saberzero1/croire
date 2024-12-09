{ flake, pkgs, ... }:
{
/*  imports = [
    flake.inputs.nixvim.homeManagerModules.nixvim
  ];
*/
  environment = {
    systemPackages = [
      flake.inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
    ];
  };

  programs.nixvim = import ./neovim.nix // {
    enable = true;
  };
}
