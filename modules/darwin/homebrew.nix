{ ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "none";
    };
    casks = [
      "ghostty"
      "gitbutler"
      "sol"
      "obsidian"
      "wavebox"
      "nordlayer"
      "espanso"
    ];
    masApps = { };
  };
}
