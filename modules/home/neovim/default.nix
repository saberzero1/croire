{ flake, ... }:
{
/*  imports = [
    flake.inputs.nixvim.homeManagerModules.nixvim
  ];
*/
  environment = {
    systemPackages = [
      inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
    ];
  };

  programs.nixvim = import ./neovim.nix // {
    enable = true;
  };
}
