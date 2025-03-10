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
      "key-codes"
      "nordlayer"
      "sol"
      "obsidian"
      "wavebox"
      "zen-browser"
    ];
    masApps = { };
    taps = [ ];
  };
}
