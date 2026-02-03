{ flake, ... }:
let
  flakeTaps = {
    "homebrew/homebrew-bundle" = flake.inputs.homebrew-bundle;
    "homebrew/homebrew-core" = flake.inputs.homebrew-core;
    "homebrew/homebrew-cask" = flake.inputs.homebrew-cask;
    "FelizKratz/homebrew-formulae" = flake.inputs.homebrew-felixkratz-tap;
    "nikitabobko/homebrew-tap" = flake.inputs.homebrew-nikitabobko-tap;
  };
in
{
  imports = [
    ./casks
    ./formulae
    ./masApps
    ./taps
  ];

  nix-homebrew = {
    enable = true;
    # enableRosetta = true;
    user = "emile";
    taps = flakeTaps;
    autoMigrate = true;
    # mutableTaps = false;
  };

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      # cleanup = "zap";
      cleanup = "none";
    };

    global = {
      autoUpdate = true;
      # brewfile = true;
    };

    taps = builtins.attrNames flakeTaps;
  };
}
