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
  };
}
