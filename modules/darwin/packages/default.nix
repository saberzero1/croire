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
    };

    global = {
      autoUpdate = true;
    };

    taps = [
      {
        name = "FelizKratz/homebrew-formulae";
        clone_target = "git@github.com:FelixKratz/homebrew-formulae.git";
      }
    ];
  };
}
