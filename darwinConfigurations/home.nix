{ inputs, ... }@flakeContext:
{
  config,
  lib,
  pkgs,
  home-manager,
  ...
}:
let
  username = inputs.self.username;
  user = "emile";
  #config = pkgs.lib.mkMerge [
  # Configure key name per device.
  #
  # Use gpg2.
  #
  # gpg2 --full-generate-key
  # gpg2 --list-secret-keys --keyid-format=long
  # gpg2 --armor --export 1234567890ABCDEF
  #  (pkgs.lib.mkIf (config.networking.hostName == "emiles-macbook-pro") {
  #    config.programs.git.signing.key = "7F462DBD67517E92";
  #  })
  #];
  # additionalFiles = import ../darwinModules/files.nix { inherit user pkgs config lib; };
  #symlink = import ../scripts/symlink.nix { inherit config pkgs lib; };
  symlink = import ./symlink.nix { inherit config pkgs lib; };
  # shelter = "/Users/${user}/Documents/Repos/dotfiles-submodules/shelter";
  shelter = "/Users/emile/Documents/Repos/dotfiles-submodules/shelter";
in
# Add out-of-store-symlinks to given attrSet
{
  imports = [
    ../darwinModules/dock
  ];
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    #ignoreShellProgramCheck = true;
    shell = pkgs.zsh;
  };
  fonts = {
    #enableFontDir = true;
    packages = with pkgs; [
      nerd-fonts.monaspace
      fira-code-symbols
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      # borg-sans-mono #DroidSansMono
      nerd-fonts.droid-sans-mono
      nerd-fonts.mononoki
    ];
    #fontConfig = {
    #  enable = true;
    #  defaultFonts = {
    #    monospace = [
    #      "Monaspace Neon"
    #	];
    #  };
    #};
  };
  homebrew = {
    enable = true;
    casks = pkgs.callPackage ../darwinModules/casks.nix { };
    # casks = inputs.self.darwinModules.casks;
    masApps = { };
  };
  home-manager = {
    useGlobalPkgs = true;
    users.${user} =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        home = {
          enableNixpkgsReleaseCheck = false;
          packages = pkgs.callPackage ../darwinModules/packages.nix { };
          # file = lib.mkMerge [
          #   additionalFiles
          # ];
          file = {
            "${config.home.homeDirectory}/wezterm" = {
              source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/wezterm";
	      recursive = true;
            };
            "${config.home.homeDirectory}/nvim/lua" = {
              source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/lua";
	      recursive = true;
            };
            "${config.home.homeDirectory}/nvim/init.lua" = {
              source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/init.lua";
            };
            "${config.home.homeDirectory}/nvim/lazy-lock.json" = {
              source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/lazy-lock.json";
            };
            "${config.home.homeDirectory}/starship.toml" = {
              source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/starship/starship.toml";
            };
            #"${config.xdg.configHome}/.zshrc" = {
            #source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/scripts/.zshrc";
            #};
            #".config/starship.toml" = {
            #source = "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/starship/starship.toml";
            #};
          };
          stateVersion = "24.05";
          sessionVariables = {
            # DEFAULT_BROWSER = "${pkgs.wavebox}/bin/wavebox";
            EDITOR = "nvim";
            VISUAL = "nvim";
            TERM = "wezterm";
	    # TERM = "${pkgs.wezterm}/Applications/Wezterm.app/"; 
            # BROWSER = "${pkgs.wavebox}/bin/wavebox";
            LAZY = "${config.home.homeDirectory}/lazy-nvim";
          };
          #sessionPath = [ "\${config.home}" ];
        };
        manual.manpages.enable = false;
        programs = {
          direnv = {
            enable = true;
            enableZshIntegration = true;
            nix-direnv.enable = true;
          };
          zsh = {
            enable = true;
            dotDir = ".config/zsh";
            autosuggestion = {
              enable = true;
            };
            enableCompletion = true;
            history = {
              save = 100000;
            };
            syntaxHighlighting = {
              enable = true;
            };
            autocd = false;
            #defaultKeymap = "vicmd";
            initExtra = ''
              # zoxide
              eval "$(zoxide init --cmd cd zsh)"
        
              # atuin
              # eval "$(atuin init zsh --disable-up-arrow)"
        
              # direnv
              eval "$(direnv hook zsh)"
        
              # starship
              eval "$(starship init zsh)"
        
              # thefuck
              eval $(thefuck --alias fuck)
        
              # Environment variables
              export EDITOR = "nvim"
              export VISUAL = "nvim"
              # export TERM = "wezterm"
            '';
          };
          git = {
            enable = true;
            ignores = [
              "*.swp"
            ];
            userName = "saberzero1";
            userEmail = "github@emilebangma.com";
            lfs = {
              enable = true;
            };
            extraConfig = {
              init.defaultBranch = "master";
              core = {
                editor = "nvim";
                autocrlf = "input";
              };
              commit.gpgsign = true;
              pull.rebase = true;
              rebase.autoStash = true;
            };
          };
          neovim = {
            defaultEditor = true;
            enable = true;
            package = pkgs.neovim-unwrapped;
            viAlias = true;
            vimAlias = true;
            vimdiffAlias = true;
            withNodeJs = true;
            withPython3 = true;
            withRuby = true;
            extraPackages = with pkgs; [
              alejandra
              black
              golangci-lint
              gopls
              gotools
              hadolint
              isort
              lua-language-server
              markdownlint-cli
              nixd
              nodePackages.bash-language-server
              nodePackages.prettier
              pyright
              ruff
              shellcheck
              shfmt
              stylua
              terraform-ls
              tflint
              vscode-langservers-extracted
              yaml-language-server
            ];
          };
          wezterm = {
            enable = true;
            package = pkgs.wezterm;
            enableZshIntegration = true;
            enableBashIntegration = true;
	    extraConfig = ''
	      local init = require "init"

	      return init
	    '';
          };
          starship = {
            enable = true;
            settings = pkgs.lib.importTOML "${config.home.homeDirectory}/.config/starship.toml";
            enableZshIntegration = true;
            enableBashIntegration = true;
          };
          tmux = {
            enable = true;
          };
          thefuck = {
            enable = true;
            enableBashIntegration = true;
            enableZshIntegration = true;
            enableInstantMode = false;
          };
          zoxide = {
            enable = true;
            package = pkgs.zoxide;
            enableZshIntegration = true;
            enableBashIntegration = true;
          };
        };
      };
  };
  local = {
    dock.enable = true;
    dock.entries = [
      #{ path = "/Applications/Safari.app"; }
      { path = "/Applications/Wavebox.app"; }
      { path = "${pkgs.wezterm}/Applications/Wezterm.app"; }
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

