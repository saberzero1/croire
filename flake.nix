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
        git = import ./nixosModules/git.nix flakeContext;
        neovim = import ./nixosModules/neovim.nix flakeContext;
        utils = import ./nixosModules/utils.nix flakeContext;
      };
    };
}
