# Dendritic feature module: Development tools and languages
# Provides unified development configuration across all platforms
# Exports: homeModules.development (languages, dev utilities)
{ inputs, lib, ... }:
let
  inherit (inputs) self;
in
{
  flake.homeModules.development =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      inherit (pkgs.stdenv) isDarwin isLinux;
    in
    {
      imports = [
        # Import all language configurations
        (self + /lib/modules/home/shared/languages)
      ];

      programs = {
        # ─────────────────────────────────────────────────────────────────────────
        # Development utilities
        # ─────────────────────────────────────────────────────────────────────────

        # Bat - Cat with syntax highlighting
        bat = {
          enable = true;
          config = {
            theme = "tokyonight_storm";
            pager = "less -FR";
          };
        };

        # Eza - Modern ls replacement
        eza = {
          enable = true;
          enableZshIntegration = true;
          enableNushellIntegration = true;
          git = true;
          icons = "auto";
        };

        # Ripgrep - Fast grep
        ripgrep = {
          enable = true;
          arguments = [
            "--smart-case"
            "--hidden"
            "--glob=!.git/*"
          ];
        };

        # jq - JSON processor
        jq.enable = true;

        # yazi - Terminal file manager
        yazi = {
          enable = true;
          enableZshIntegration = true;
          enableNushellIntegration = true;
        };

        # btop - System monitor
        btop = {
          enable = true;
          settings = {
            color_theme = "tokyo-night";
            theme_background = false;
            vim_keys = true;
          };
        };
      };

      # ─────────────────────────────────────────────────────────────────────────
      # Development packages
      # ─────────────────────────────────────────────────────────────────────────
      home.packages = with pkgs; [
        # Core dev tools
        gnumake
        cmake
        pkg-config

        # File utilities
        fd
        tree

        # Network utilities
        curl
        wget
        httpie

        # Archive utilities
        unzip
        zip

        # Process utilities
        htop
        procs

        # Disk utilities
        dust
        duf

        # Documentation
        tldr
        man-pages
      ];
    };
}
