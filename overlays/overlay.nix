# Overlays for the Nix package set
# Called with { inputs } from modules/overlays.nix
{ inputs }:

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
  fh = inputs.fh.packages.${self.pkgs.stdenv.hostPlatform.system}.default;
  ghostty = inputs.ghostty.packages.${self.pkgs.stdenv.hostPlatform.system}.default;
  nix-direnv = inputs.nix-direnv.packages.${self.pkgs.stdenv.hostPlatform.system}.default;
  nixgl = inputs.nixgl.packages.${self.pkgs.stdenv.hostPlatform.system}.default;
  omnix = inputs.omnix.packages.${self.pkgs.stdenv.hostPlatform.system}.default;
  opencode = inputs.opencode.packages.${self.pkgs.stdenv.hostPlatform.system}.default;
  opencode-desktop = inputs.opencode.packages.${self.pkgs.stdenv.hostPlatform.system}.desktop;

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

  # Gaming packages from play.nix
  proton-cachyos =
    inputs.play-nix.packages.${self.pkgs.stdenv.hostPlatform.system}.proton-cachyos or null;
  procon2-init =
    inputs.play-nix.packages.${self.pkgs.stdenv.hostPlatform.system}.procon2-init or null;
  sash = inputs.sash.packages.${self.pkgs.stdenv.hostPlatform.system}.default;

  # comment-checker: Multi-language comment detection hook for Claude Code / OpenCode
  # Uses tree-sitter via CGo for AST-based comment detection
  comment-checker = super.buildGoModule {
    pname = "comment-checker";
    version = "0.7.0";
    src = inputs.comment-checker;
    vendorHash = "sha256-cW/cWo6k7aA/Z2w6+CBAdNKhEiWN1cZiv/hl2Mto6Gw=";
    subPackages = [ "cmd/comment-checker" ];
    proxyVendor = true;
    meta = with super.lib; {
      description = "Multi-language comment detection hook for Claude Code / OpenCode";
      homepage = "https://github.com/code-yeongyu/go-claude-code-comment-checker";
      license = licenses.mit;
      mainProgram = "comment-checker";
    };
  };

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

  # Obsidian: override to 1.11.7 for new CLI features
  # See: https://help.obsidian.md/cli
  # Fix: Wayland flags must come BEFORE app.asar, otherwise they're passed to Obsidian's CLI
  obsidian =
    let
      version = "1.11.7";
      src = super.fetchurl {
        url =
          if super.stdenv.hostPlatform.isDarwin then
            "https://github.com/obsidianmd/obsidian-releases/releases/download/v${version}/Obsidian-${version}.dmg"
          else
            "https://github.com/obsidianmd/obsidian-releases/releases/download/v${version}/obsidian-${version}.tar.gz";
        hash =
          if super.stdenv.hostPlatform.isDarwin then
            "sha256-TRE9ymNtpcp7gEbuuSfJxvYDXLDVNz+o4+RSNyHZgmE="
          else
            "sha256-HrqeFJ2C5uZw0IBtD9y607V6007fOwnA0KnA83cwWjg=";
      };
    in
    if super.stdenv.hostPlatform.isDarwin then
      super.obsidian.overrideAttrs (oldAttrs: {
        inherit version src;
      })
    else
      # Linux: rebuild with wrapper that properly handles CLI
      # The app.asar contains Electron's single-instance logic which routes CLI to running instance
      super.stdenv.mkDerivation {
        pname = "obsidian";
        inherit version src;
        inherit (super.obsidian) icon desktopItem meta;
        nativeBuildInputs = [
          super.makeWrapper
          super.imagemagick
        ];
        installPhase = ''
          runHook preInstall
          mkdir -p $out/bin

          install -m 444 -D resources/app.asar $out/share/obsidian/app.asar
          install -m 444 -D resources/obsidian.asar $out/share/obsidian/obsidian.asar

          # Smart wrapper that handles:
          # 1. Fresh launch (Obsidian not running): start with app.asar + Wayland flags
          # 2. CLI/TUI mode (Obsidian running): connect without Wayland flags
          #
          # When Obsidian is running, Electron's single-instance mechanism forwards args
          # to the existing process. Wayland flags get interpreted as CLI commands.
          cat > $out/bin/obsidian << 'WRAPPER'
          #!${super.bash}/bin/bash
          ELECTRON="${super.electron}/bin/electron"
          APP_ASAR="$out/share/obsidian/app.asar"

          # Check if Obsidian is already running (look for electron process with obsidian asar)
          if pgrep -f "electron.*obsidian" > /dev/null 2>&1; then
            # Obsidian is running: connect to existing instance (CLI/TUI mode)
            # No Wayland flags - they'd be forwarded to Obsidian CLI as commands
            exec "$ELECTRON" "$APP_ASAR" "$@"
          else
            # Obsidian not running: launch fresh instance with Wayland support
            WAYLAND_FLAGS=""
            if [[ -n "$NIXOS_OZONE_WL" && -n "$WAYLAND_DISPLAY" ]]; then
              WAYLAND_FLAGS="--ozone-platform=wayland"
            fi
            exec "$ELECTRON" $WAYLAND_FLAGS "$APP_ASAR" "$@"
          fi
          WRAPPER
          chmod +x $out/bin/obsidian

          # Substitute the actual path
          substituteInPlace $out/bin/obsidian \
            --replace-fail '$out' "$out"

          install -m 444 -D "${super.obsidian.desktopItem}/share/applications/"* \
            -t $out/share/applications/

          for size in 16 24 32 48 64 128 256 512; do
            mkdir -p $out/share/icons/hicolor/"$size"x"$size"/apps
            magick -background none ${super.obsidian.icon} -resize "$size"x"$size" $out/share/icons/hicolor/"$size"x"$size"/apps/obsidian.png
          done
          runHook postInstall
        '';
      };
}
