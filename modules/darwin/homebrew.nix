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
    /*
      brews = [
        {
          name = "koekeishiya/formulae/skhd";
        }
        {
          name = "koekeishiya/formulae/yabai";
        }
      ];
    */
    casks = [
      "espanso"
      "ghostty"
      "gimp"
      "gitbutler"
      "key-codes"
      "nordlayer"
      "obsidian"
      "sol"
      "wavebox"
      "zen-browser"
    ];
    masApps = { };
    taps = [ ];
  };
}
