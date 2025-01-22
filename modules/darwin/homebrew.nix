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
        args = [ "--force" ];
        greedy = true;
      }
      {
        name = "gitbutler";
        args = [ "--force" ];
        greedy = true;
      }
      "nordlayer"
      "sol"
      "obsidian"
      {
        name = "wavebox";
        args = [ "--force" ];
        greedy = true;
      }
    ];
    masApps = { };
  };
}
