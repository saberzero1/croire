{ ... }:
{
  homebrew = {
    enable = true;
    # casks = pkgs.callPackage ./casks.nix { };
    # casks = inputs.self.darwinModules.casks;
    casks = [
      "sol"
      "obsidian"
      "wavebox"
      "nordlayer"
    ];
    masApps = { };
  };
}
