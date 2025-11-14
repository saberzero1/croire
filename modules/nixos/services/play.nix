{ flake, lib, config, ... }:
let
  inherit (flake) inputs;
  cfg = config.play;
in
{
  options.play = {
    enable = lib.mkEnableOption "play.nix gaming setup";
  };

  config = lib.mkIf cfg.enable {
    imports = [
      inputs.play-nix.nixosModules.play
    ];

    # Enable basic gaming support
    play = {
      enable = true;
    };
  };
}
