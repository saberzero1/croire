{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  imports = [
    inputs.self.nixosModules.javascript
    inputs.self.nixosModules.lua
    inputs.self.nixosModules.python
    inputs.self.nixosModules.ruby
  ];
}
