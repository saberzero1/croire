{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  environment = {
    systemPackages = with pkgs; [
      diff-so-fancy
      gh
      lazygit
      gitFull
      tree-sitter

      xcodes
      apple-sdk
      pre-commit

      bun

      opencode

      ruby
      rubyPackages.nokogiri
      rubyPackages.solargraph
    ];
  };
}
