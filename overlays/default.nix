{ flake, ... }:
let
  inherit (flake) inputs;
in

self: super:
let
  # Import stable nixpkgs for Swift-dependent packages (Swift broken in unstable with clang-21)
  # See: https://github.com/NixOS/nixpkgs/issues/461474
  # Only needed on Darwin where Swift is used for dotnet, dockutil, xcodes, etc.
  pkgsStable = import inputs.nixpkgs-stable {
    inherit (super.stdenv.hostPlatform) system;
    config.allowUnfree = true;
  };

  # Swift-related overrides only apply on Darwin
  # NOTE: dotnet-sdk is completely broken on Darwin (nixpkgs #450126) - use Homebrew instead
  # Only Swift packages (dockutil, xcodes) are pinned to stable where Swift 5.8 works
  swiftOverrides =
    if super.stdenv.hostPlatform.isDarwin then
      {
        # Swift and Swift-dependent packages from stable nixpkgs (clang-21 breaks Swift 5.10.1)
        # These will be removed once Swift is fixed in nixpkgs-unstable
        inherit (pkgsStable)
          swift
          swiftpm
          swiftPackages
          # Packages that depend on Swift
          dockutil
          xcodes
          ;
      }
    else
      { };
in
swiftOverrides
  // {
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
  opencode = inputs.opencode.packages.${self.pkgs.stdenv.hostPlatform.system}.default;
  # tmux-sessionizer: base package from flake input (no nushell dependency)
  tmux-sessionizer =
    inputs.tmux-sessionizer.packages.${super.stdenv.hostPlatform.system}.tmux-sessionizer;

  # tmux-sessionizer-nu: rebuild locally to use our nushell (with doCheck=false)
  # The flake's prebuilt package uses its own nushell which fails to build
  tmux-sessionizer-nu = super.stdenv.mkDerivation {
    pname = "tmux-sessionizer-nu";
    version = "0.1.0";
    src = inputs.tmux-sessionizer;
    nativeBuildInputs = [ super.makeWrapper ];
    buildInputs = [ self.nushell ];
    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin
      cp tmux-sessionizer.nu $out/bin/tmux-sessionizer.nu
      chmod +x $out/bin/tmux-sessionizer.nu
      wrapProgram $out/bin/tmux-sessionizer.nu \
        --prefix PATH : ${
          super.lib.makeBinPath [
            self.nushell
            super.tmux
            super.fzf
            super.findutils
            super.procps
            super.coreutils
          ]
        }
      runHook postInstall
    '';
    meta = {
      description = "Fuzzy-finder for tmux sessions (Nushell version)";
      mainProgram = "tmux-sessionizer.nu";
    };
  };
  # wezterm = inputs.wezterm.packages.${self.pkgs.stdenv.hostPlatform.system}.default;
  # zed-latest = inputs.zed.packages.${self.pkgs.stdenv.hostPlatform.system}.default;

  # Gaming packages from play.nix
  proton-cachyos =
    inputs.play-nix.packages.${self.pkgs.stdenv.hostPlatform.system}.proton-cachyos or null;
  procon2-init =
    inputs.play-nix.packages.${self.pkgs.stdenv.hostPlatform.system}.procon2-init or null;
  sash = inputs.sash.packages.${self.pkgs.stdenv.hostPlatform.system}.default;

  # tirith: Terminal security - guards against homograph attacks, ANSI injection, pipe-to-shell attacks
  # Tests disabled: init_bash_output and init_zsh_output require bash/zsh in sandbox
  tirith = super.rustPlatform.buildRustPackage {
    pname = "tirith";
    version = "0.1.2";
    src = inputs.tirith;
    cargoLock.lockFile = "${inputs.tirith}/Cargo.lock";
    doCheck = false;
    nativeBuildInputs = [ super.installShellFiles ];
    postInstall = ''
      # Install shell integration scripts
      install -Dm644 $src/shell/tirith.sh $out/share/tirith/tirith.sh
      install -Dm644 $src/shell/lib/zsh-hook.zsh $out/share/tirith/lib/zsh-hook.zsh
      install -Dm644 $src/shell/lib/bash-hook.bash $out/share/tirith/lib/bash-hook.bash
      install -Dm644 $src/shell/lib/fish-hook.fish $out/share/tirith/lib/fish-hook.fish
    '';
    meta = with super.lib; {
      description = "Terminal security - guards against homograph attacks, ANSI injection, and pipe-to-shell attacks";
      homepage = "https://github.com/sheeki03/tirith";
      license = licenses.asl20;
      mainProgram = "tirith";
    };
  };

  # Nushell: skip tests that fail in Nix sandbox (permission denied in path_is_a_list_in_repl)
  nushell = super.nushell.overrideAttrs (oldAttrs: {
    doCheck = false;
    checkPhase = "";
    cargoTestFlags = [
      "--skip"
      "this_test_does_not_exist"
    ];
  });
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
