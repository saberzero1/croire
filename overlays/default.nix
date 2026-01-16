{ flake, ... }:
let
  inherit (flake) inputs;
in

self: super: {
  devour-flake = self.callPackage inputs.devour-flake { };
  # direnv = super.direnv.overrideAttrs (oldAttrs: {
  #   # Remove fish from nativeCheckInputs to avoid unnecessary dependency
  #   nativeCheckInputs = builtins.filter (pkg: pkg != self.pkgs.fish) (
  #     oldAttrs.nativeCheckInputs or [ ]
  #   );
  #   checkPhase = ''
  #     runHook preCheck
  #     make test-go test-bash test-zsh
  #     runHook postCheck
  #   '';
  # });
  # doom-emacs = inputs.nix-doom-emacs-unstraightened.packages.${self.pkgs.stdenv.hostPlatform.system}.default;
  fh = inputs.fh.packages.${self.pkgs.stdenv.hostPlatform.system}.default;
  # fish = super.fish.overrideAttrs (oldAttrs: {
  #   # Disable all tests
  #   doCheck = false;
  #   checkPhase = "";
  #   cmakeFlags = (oldAttrs.cmakeFlags or [ ]) ++ [
  #     "BUILD_DOCS=OFF"
  #     "INSTALL_DOCS=OFF"
  #     "-DENABLE_TESTS=OFF"
  #     "-DFISH_TESTS=OFF"
  #     "-DBUILD_TESTING=OFF"
  #   ];
  # });
  ghostty = inputs.ghostty.packages.${self.pkgs.stdenv.hostPlatform.system}.default;
  # gitbutler = inputs.gitbutler.packages.${self.pkgs.stdenv.hostPlatform.system}.default;
  # neovim = inputs.neovim-nightly-overlay.packages.${self.pkgs.stdenv.hostPlatform.system}.default;
  # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${self.pkgs.stdenv.hostPlatform.system}.default;
  # nix = inputs.determinate-nix.packages.${self.pkgs.stdenv.hostPlatform.system}.default;
  nix-direnv = inputs.nix-direnv.packages.${self.pkgs.stdenv.hostPlatform.system}.default;
  nixgl = inputs.nixgl.packages.${self.pkgs.stdenv.hostPlatform.system}.default;
  # nixvim = inputs.akira.packages.${self.pkgs.stdenv.hostPlatform.system}.default;
  omnix = inputs.omnix.packages.${self.pkgs.stdenv.hostPlatform.system}.default;
  tmux-sessionizer = inputs.tmux-sessionizer.packages.${self.pkgs.stdenv.hostPlatform.system}.default;
  # wezterm = inputs.wezterm.packages.${self.pkgs.stdenv.hostPlatform.system}.default;
  # zed-latest = inputs.zed.packages.${self.pkgs.stdenv.hostPlatform.system}.default;

  # Gaming packages from play.nix
  proton-cachyos =
    inputs.play-nix.packages.${self.pkgs.stdenv.hostPlatform.system}.proton-cachyos or null;
  procon2-init =
    inputs.play-nix.packages.${self.pkgs.stdenv.hostPlatform.system}.procon2-init or null;
  sash = inputs.sash.packages.${self.pkgs.stdenv.hostPlatform.system}.default;
}

# shamelessly stolen from https://github.com/Sileanth/nixosik/blob/63354cf060e9ba895ccde81fd6ccb668b7afcfc5/overlays/default.nix
# This file defines overlaysa

# https://nixos-and-flakes.thiscute.world/nixpkgs/overlays

#{inputs, ...}: {

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

#nvim-nightly = inputs.neovim-nightly-overlay.overlays.default;

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

#}
