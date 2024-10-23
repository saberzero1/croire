# shamelessly stolen from https://github.com/Sileanth/nixosik/blob/63354cf060e9ba895ccde81fd6ccb668b7afcfc5/overlays/default.nix
# This file defines overlaysa

# https://nixos-and-flakes.thiscute.world/nixpkgs/overlays

{inputs, ...}: {

  # This one brings our custom packages from the 'pkgs' directory
  # additions = final: _prev: import ../pkgs {pkgs = final;};

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  #modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });

    # https://wavebox.io/download
    #wavebox = prev.wavebox.overrideAttrs (oldAttrs: rec {
      #version = "10.129.32-2";
    #});
  #};

  nvim-nightly = inputs.neovim-nightly-overlay.overlays.default;

  #pkgs = import nixpkgs {
  #  config = {
  #    packageOverrides = pkgs: {
  #      espanso = pkgs.espanso.override {
  #        x11Support = false;
  #        waylandSupport = true;
  #      };
  #      wavebox = pkgs.wavebox.override {
  #        version = "10.129.32-2";
  #      };
  #    };
  #  };
  #};

  # # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # # be accessible through 'pkgs.unstable'
  # unstable-packages = final: _prev: {
  #   unstable = import inputs.nixpkgs-unstable {
  #     system = final.system;
  #     config.allowUnfree = true;
  #   };
  # };

}
