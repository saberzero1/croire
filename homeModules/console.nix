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
        pkgs.nautilus-open-any-terminal
        pkgs.python312Packages.pynvim
        pkgs.neovim-unwrapped
        pkgs.git
        pkgs.gnumake
        pkgs.unzip
        pkgs.gcc
        pkgs.ripgrep
        pkgs.fd
        pkgs.jq
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
    };
    xdg = {
      configFile = {
        "wezterm/wezterm.lua" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/wezterm.lua"; };
        "nvim/init.lua" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/init.lua"; };
        "nvim/lazy-lock.json" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/lazy-lock.json"; };
        "nvim/.stylua.toml" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/.stylua.toml"; };
        "nvim/neovim.yml" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/neovim.yml"; };
        "nvim/lua" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/lua"; };
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
