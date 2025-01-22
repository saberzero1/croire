{ ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
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
