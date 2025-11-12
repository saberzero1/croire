{ ... }:
{
  imports = [
    ./casks
    ./formulae
    ./masApps
    ./taps
  ];

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
      # cleanup = "none";
    };

    global = {
      autoUpdate = true;
      brewfile = true;
    };

    taps = [
      {
        name = "FelizKratz/homebrew-formulae";
        clone_target = "git@github.com:FelixKratz/homebrew-formulae.git";
      }
      {
        name = "nikitabobko/tap";
        clone_target = "git@github.com:nikitabobko/homebrew-tap.git";
      }
    ];
  };
}
