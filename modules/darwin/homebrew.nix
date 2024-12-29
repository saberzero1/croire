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
      "sol"
      "obsidian"
      "wavebox"
      "nordlayer"
      "espanso"
    ];
    masApps = { };
  };
}
