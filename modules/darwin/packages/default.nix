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
      autoUpdate = false;
    };
  };
}
