{ pkgs, ... }:
{
  services.sketchybar = {
    enable = true;
    extraPackages = with pkgs.nerd-fonts; [ 
      victor-mono
      mononoki
    ];
  };
}
