{ lib, ... }:
let
  product = lib.lists.foldr (a: b: a * b) 1;
in
{
  home.sessionVariables = {
    HOMEBREW_AUTO_UPDATE_SEC = product [
      60
      60
      24
      7
    ];
    TS_EXTRA_SEARCH_PATHS = "(~/Work/Repos ~/Work/External/Repos)";
    SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt"; # "$(echo $NIX_SSL_CERT_FILE)";
  };
}
