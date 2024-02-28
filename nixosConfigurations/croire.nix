{ inputs, ... }@flakeContext:
let
  nixosModule = { config, lib, pkgs, ... }: {
    imports = [
      inputs.self.nixosModules.browser
      inputs.self.nixosModules.console
      inputs.self.nixosModules.desktop
      inputs.self.nixosModules.development
      inputs.self.nixosModules.git
      inputs.self.nixosModules.programming_languages
      inputs.self.nixosModules.security
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
