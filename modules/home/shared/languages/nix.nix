{ pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        nixd
        nixpkgs-fmt
        nixfmt-rfc-style
      ];
    };
  };
}
