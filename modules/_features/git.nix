# Dendritic feature module: Git configuration
# Provides unified git configuration across all platforms (Darwin, NixOS)
# Exports: homeModules.git
{ inputs, lib, ... }:
let
  inherit (inputs) self;
in
{
  flake.homeModules.git =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      inherit (pkgs.stdenv) isDarwin isLinux;
      signingKeyPath = "${config.home.homeDirectory}/.ssh/saberzero1-github.pub";
    in
    {
      programs = {
        git = {
          enable = true;
          package = pkgs.gitFull;

          # User identity
          userName = "saberzero1";
          userEmail = "github@emilebangma.com";

          # Signing configuration
          signing = {
            key = signingKeyPath;
            signByDefault = true;
          };

          # Common ignores
          ignores = [
            "*.swp"
            ".DS_Store"
            ".direnv/"
            ".envrc"
          ];

          # Git LFS
          lfs.enable = true;

          # Conditional includes (Darwin-specific for work repos)
          includes = lib.optionals isDarwin [
            {
              path = "${config.home.homeDirectory}/work_gitconfig";
              condition = "gitdir:${config.home.homeDirectory}/Work/External/Repos/**";
            }
          ];

          extraConfig = {
            init.defaultBranch = "master";
            core = {
              editor = "nvim";
              autocrlf = "input";
            };
            commit.gpgsign = true;
            tag.gpgsign = true;
            gpg.format = "ssh";
            user.signingkey = signingKeyPath;
            pull.rebase = true;
            rebase.autoStash = true;
          };
        };

        # Enhanced diff viewer
        diff-so-fancy = {
          enable = true;
          enableGitIntegration = true;
          settings = {
            changeHunkIndicators = true;
            markEmptyLines = true;
            pagerOpts = "--tabs=4 -RFX";
            stripLeadingSymbols = true;
            useUnicodeRuler = true;
          };
        };

        # Lazygit TUI (enabled on all platforms)
        lazygit = {
          enable = true;
          package = pkgs.lazygit;
          enableNushellIntegration = true;
          settings = {
            gui = {
              nerdFontsVersion = "3";
              theme = {
                activeBorderColor = [
                  "#ff9e64"
                  "bold"
                ];
                inactiveBorderColor = [ "#29a4bd" ];
                searchingActiveBorderColor = [
                  "#ff9e64"
                  "bold"
                ];
                optionsTextColor = [ "#7aa2f7" ];
                selectedLineBgColor = [ "#2e3c64" ];
                cherryPickedCommitFgColor = [ "#7aa2f7" ];
                cherryPickedCommitBgColor = [ "#bb92f7" ];
                markedBaseCommitFgColor = [ "#7aa2f7" ];
                markedBaseCommitBgColor = [ "#e0af68" ];
                unstagedChangesColor = [ "#db4b4b" ];
                defaultFgColor = [ "#c0caf5" ];
              };
            };
          };
        };

        # GitHub CLI
        gh = {
          enable = true;
          settings = {
            git_protocol = "ssh";
            prompt = "enabled";
          };
        };
      };
    };
}
