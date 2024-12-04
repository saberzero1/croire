{ inputs, ... }@flakeContext:
{ config, lib, pkgs, home-manager, ... }:
let
  username = inputs.self.username;
  user = "emile";
  config = pkgs.lib.mkMerge [
    # Configure key name per device.
    #
    # Use gpg2.
    #
    # gpg2 --full-generate-key
    # gpg2 --list-secret-keys --keyid-format=long
    # gpg2 --armor --export 1234567890ABCDEF
    (pkgs.lib.mkIf (config.networking.hostName == "emiles-macbook-pro") {
      config.programs.git.signing.key = "7F462DBD67517E92";
    })
  ];
  additionalFiles = import ../darwinModules/files.nix { inherit user config lib pkgs; };
in
{
  imports = [
    ../darwinModules/dock
  ];
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };
  homebrew = {
    enable = true;
    casks = pkgs.callPackage ../darwinModules/casks.nix {};
    masApps = {}; 
  };
  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { pkgs, config, lib, ...}: {
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = pkgs.callPackage ../darwinModules/packages.nix {};
        file = lib.mkMerge [
          additionalFiles
        ];
        stateVersion = "24.05";
      };
      manual.manpages.enable = false;
    };
  };
  local = {
    dock.enable = true;
    dock.entries = [
      { path = "/System/Applications/Home.app/"; }
      { path = "${pkgs.wezterm}/Applications/Wezterm.app/"; }
    ];
  };
  #config = {
  #  environment = {
  #    systemPackages = with pkgs; [
  #      git
  #      lazygit
  #    ];
  #  };  
  #  programs = {
      #git = {
      #  config = {
      #    init = {
      #      defaultBranch = "master";
      #    };
      #    url = {
      #      "https://github.com/" = {
      #        insteadOf = [
      #          "gh:"
      #          "github:"
      #        ];
      #      };
      #    };
      #  };
      #  diff-so-fancy = {
      #    changeHunkIndicators = true;
      #    enable = true;
      #    markEmptyLines = true;
      #    pagerOpts = [
      #      "--tabs=4"
      #      "-RFX"
      #    ];
      #    rulerWidth = null;
      #    stripLeadingSymbols = true;
      #    useUnicodeRuler = true;
      #  };
      #  enable = true;
      #  package = pkgs.git;
      #  signing = {
      #    key = null;
      #    signByDefault = true;
      #  };
      #  userEmail = "github@emilebangma.com";
      #  userName = "saberzero1";
      #};
      #gh = {
      #  enable = true;
      #  package = pkgs.gh;
      #  gitCredentialHelper = {
      #    enable = true;
      #    hosts = [
      #      "https://github.com"
      #      "https://gist.github.com"
      #    ];
      #  };
      #  extensions = [
      #    pkgs.gh-dash
      #  ];
      #};
      #lazygit = {
      #  enable = true;
      #  package = pkgs.lazygit;
      #  settings = {
      #    gui = {
      #      nerdFontsVersion = "3";
      #      theme = {
      #        activeBorderColor = [
      #          "#ff9e64"
      #          "bold"
      #        ];
      #        inactiveBorderColor = [
      #          "#29a4bd"
      #        ];
      #        searchingActiveBorderColor = [
      #          "#ff9e64"
      #          "bold"
      #        ];
      #        optionsTextColor = [
      #          "#7aa2f7"
      #        ];
      #        selectedLineBgColor = [
      #          "#2e3c64"
      #        ];
      #        cherryPickedCommitFgColor = [
      #          "#7aa2f7"
      #        ];
      #        cherryPickedCommitBgColor= [
      #          "#bb92f7"
      #        ];
      #        markedBaseCommitFgColor = [
      #          "#7aa2f7"
      #        ];
      #        markedBaseCommitBgColor = [
      #          "#e0af68"
      #        ];
      #        unstagedChangesColor = [
      #          "#db4b4b"
      #        ];
      #        defaultFgColor = [
      #          "#c0caf5"
      #        ];
      #      };
      #    };
      #  };
      #};
  #  };
  #};
}