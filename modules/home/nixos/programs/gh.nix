{ pkgs, ... }:
{
  programs.gh = {
    enable = true;
    package = pkgs.gh;
    gitCredentialHelper = {
      enable = true;
      hosts = [
        "https://github.com"
        "https://gist.github.com"
      ];
    };
    extensions = [
      pkgs.gh-dash
    ];
  };
}
