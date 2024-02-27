{
  description = "NixOS Configuration.";
  inputs = {
    nixpkgs.url = "flake:nixpkgs/nixpkgs-unstable";
  };
  outputs = inputs:
    let
      flakeContext = {
        inherit inputs;
      };
    in
    {
      nixosConfigurations = {
        croire = import ./nixosConfigurations/croire.nix flakeContext;
      };
      nixosModules = {
        neovim = import ./nixosModules/neovim.nix flakeContext;
      };
    };
}
