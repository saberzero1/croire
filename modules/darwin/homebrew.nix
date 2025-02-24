{ ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
      #extraFlags = [ "--force" ];
    };
    global = {
      autoUpdate = false;
    };
    casks = [
      "espanso"
      "ghostty"
      "gitbutler"
      "nordlayer"
      "sol"
      "obsidian"
      "wavebox"
    ];
    masApps = { };
    taps = [ ];
  };
}
