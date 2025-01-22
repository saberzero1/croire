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
      "espanso"
      {
        name = "ghostty";
        greedy = true;
      }
      {
        name = "gitbutler";
        greedy = true;
      }
      "nordlayer"
      "sol"
      "obsidian"
      {
        name = "wavebox";
        greedy = true;
      }
    ];
    masApps = { };
  };
}
