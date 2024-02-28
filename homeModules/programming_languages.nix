{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  imports = [
    inputs.self.homeModules.javascript
    inputs.self.homeModules.python
    inputs.self.homeModules.ruby
  ];
}
