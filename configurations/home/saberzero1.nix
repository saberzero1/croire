{ flake
, config
, pkgs
, lib
, ...
}:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.homeModules.shared
    self.homeModules.nixos
  ];
  home = {
    username = "saberzero1";
    homeDirectory = lib.mkDefault "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/saberzero1";
    stateVersion = "24.05";
  };

  config = pkgs.lib.mkMerge [
    # Configure key name per device.
    #
    # Use gpg2.
    #
    # gpg2 --full-generate-key
    # gpg2 --list-secret-keys --keyid-format=long
    # gpg2 --armor --export 1234567890ABCDEF
    (pkgs.lib.mkIf (config.networking.hostName == "nixos") {
      config.programs.git.signing.key = "41AEE99107640F10";
    })
    (pkgs.lib.mkIf (config.networking.hostName == "croire") {
      config.programs.git.signing.key = null;
    })
    (pkgs.lib.mkIf (config.networking.hostName == "croire-low") {
      config.programs.git.signing.key = "198769D1B0D0DF8C";
    })
  ];
}
