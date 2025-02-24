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
      "ghostty@tip"
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
