{ inputs, ... }@flakeContext:
let
  nixosModule = { config, lib, pkgs, ... }: {
    imports = [
      inputs.self.nixosModules.git
      inputs.self.nixosModules.neovim
      inputs.self.nixosModules.system
      inputs.self.nixosModules.utils
    ];
  };
in
inputs.nixpkgs.lib.nixosSystem {
  modules = [
    nixosModule
  ];
  system = "x86_64-linux";
}
