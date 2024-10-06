{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  imports = [
    inputs.self.homeModules.neovim_language_dependencies
  ];
  config = {
    home = {
      packages = [
        pkgs.zsh
        pkgs.zsh-you-should-use
        pkgs.zsh-vi-mode
        pkgs.wezterm
        pkgs.python312Packages.pynvim
        pkgs.neovim-unwrapped
        pkgs.git
        pkgs.gnumake
        pkgs.unzip
        pkgs.gcc
        pkgs.ripgrep
        pkgs.fd
        pkgs.jq
        #pkgs.emacs-unstable
      ];
      shellAliases = {
        vi = "nvim";
        vim = "nvim";
        vimdiff = "nvim -d";
      };
    };
    programs = {
      zsh = {
        dotDir = ".config/zsh";
        enable = true;
        enableCompletion = true;
        history = {
          save = 100000;
        };
        package = pkgs.zsh;
        profileExtra = ''

        '';
        syntaxHighlighting = {
          enable = true;
        };
        shellAliases = {
          uuid = "uuidgen";
          ll = "ls -l";
          ".." = "cd ..";
        };
        enableVteIntegration = true;

        # This command let's me execute arbitrary binaries downloaded through channels such as mason.
        initExtra = ''
          export NIX_LD=$(nix eval --impure --raw --expr 'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD')
        '';
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
      };
      emacs = {
        enable = true;
        #package = pkgs.emacs-unstable;
        package = (pkgs.emacsWithPackagesFromUsePackage {
          # Your Emacs config file. Org mode babel files are also
          # supported.
          # NB: Config files cannot contain unicode characters, since
          #     they're being parsed in nix, which lacks unicode
          #     support.
          # config = ./emacs.org;
          config = "emacs/init.el";

          # Whether to include your config as a default init file.
          # If being bool, the value of config is used.
          # Its value can also be a derivation like this if you want to do some
          # substitution:
          #   defaultInitFile = pkgs.substituteAll {
          #     name = "default.el";
          #     src = ./emacs.el;
          #     inherit (config.xdg) configHome dataHome;
          #   };
          #defaultInitFile = true;
          defaultInitFile = pkgs.substituteAll {
            name = "default.el";
            src = "${dataHome}/emacs/init.el";
            inherit (config.xdg) configHome dataHome;
          };

          # Package is optional, defaults to pkgs.emacs
          package = pkgs.emacs-unstable;

          # By default emacsWithPackagesFromUsePackage will only pull in
          # packages with `:ensure`, `:ensure t` or `:ensure <package name>`.
          # Setting `alwaysEnsure` to `true` emulates `use-package-always-ensure`
          # and pulls in all use-package references not explicitly disabled via
          # `:ensure nil` or `:disabled`.
          # Note that this is NOT recommended unless you've actually set
          # `use-package-always-ensure` to `t` in your config.
          alwaysEnsure = true;

          # For Org mode babel files, by default only code blocks with
          # `:tangle yes` are considered. Setting `alwaysTangle` to `true`
          # will include all code blocks missing the `:tangle` argument,
          # defaulting it to `yes`.
          # Note that this is NOT recommended unless you have something like
          # `#+PROPERTY: header-args:emacs-lisp :tangle yes` in your config,
          # which defaults `:tangle` to `yes`.
          alwaysTangle = true;

          # Optionally provide extra packages not in the configuration file.
          extraEmacsPackages = epkgs: [
            epkgs.cask
          ];

          # Optionally override derivations.
          override = final: prev: {
            weechat = prev.melpaPackages.weechat.overrideAttrs(old: {
              patches = [ ./weechat-el.patch ];
            });
          };
        });
      };
    };
    xdg = {
      configFile = {
        "wezterm/wezterm.lua" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/wezterm.lua"; };
        "nvim/init.lua" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/init.lua"; };
        "nvim/lazy-lock.json" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/lazy-lock.json"; };
        "nvim/.stylua.toml" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/.stylua.toml"; };
        "nvim/neovim.yml" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/neovim.yml"; };
        "nvim/lua" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/lua"; };
        "emacs/init.el" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/init.el"; };
        #"emacs" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/init.el"; };
      };
      desktopEntries = {
        "nvim" = {
          name = "nvim";
          comment = "Edit text files";
          icon = "nvim";
          exec = "${pkgs.wezterm}/bin/wezterm -e ${inputs.neovim-nightly-overlay.packages.${pkgs.system}.default}/bin/nvim %F";
          #exec = "${pkgs.wezterm}/bin/wezterm -e ${pkgs.neovim-unwrapped}/bin/nvim %F";
          categories = [ "Application" ];
          terminal = false;
          mimeType = [ "text/plain" ];
        };
      };
    };
  };
}
