{ pkgs, ... }:
{
  # Better `cat`
  programs.bat = {
    enable = true;
    config = {
      theme = "tokyonight_storm";
    };
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batgrep
      batman
      batpipe
      batwatch
      prettybat
    ];
  };
}
