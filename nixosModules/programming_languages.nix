{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  imports = [
    inputs.self.nixosModules.javascript
    inputs.self.nixosModules.python
    inputs.self.nixosModules.ruby
  ];
}
