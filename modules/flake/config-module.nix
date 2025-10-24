# https://github.com/juspay/nixos-unified-template/blob/9eeeb6c1ab4287ac0a37a22e72f053a3de82ddbc/modules/flake/config-module.nix
# Global module configuration
{ self, ... }:
{
  # Make croire-lib available to all NixOS, Darwin, and Home Manager modules
  flake.nixosModules.croire-lib = {
    _module.args.croire-lib = self.lib.croire;
  };
  
  flake.darwinModules.croire-lib = {
    _module.args.croire-lib = self.lib.croire;
  };
  
  flake.homeModules.croire-lib = {
    _module.args.croire-lib = self.lib.croire;
  };
}
