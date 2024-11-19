{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  imports = [
    inputs.self.homeModules.neovim_language_dependencies
  ];
  config = {
    home = {
      packages = with pkgs; [
        zsh
        zsh-autosuggestions
        zsh-completions
        zsh-syntax-highlighting
        zsh-vi-mode
        zsh-you-should-use
        wezterm
        python312Packages.pynvim
        neovim-unwrapped
        git
        gnumake
        unzip
        gcc
        direnv
        nix-direnv
        atuin # https://haseebmajid.dev/posts/2023-08-12-how-sync-your-shell-history-with-atuin-in-nix/
        fzf
        ripgrep
        ripgrep-all
        zoxide
        fd
        jq
        #emacs-unstable
        ranger
        fira-code
        fira-code-symbols
        (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "mononoki" ]; })
        #nerdfonts
        monaspace
        starship
        thefuck
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
        autosuggestion = {
          enable = true;
        };
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

          # zoxide
          eval "$(zoxide init --cmd cd zsh)"

          # atuin
          eval "$(atuin init zsh --disable-up-arrow)"

          # direnv
          eval "$(direnv hook zsh)"

          # starship
          eval "$(starship init zsh)"

          # thefuck
          eval $(thefuck --alias fuck)

          # gnome
          eval $(dbus-update-activation-environment --systemd --all)
          # eval $(/run/wrappers/bin/gnome-keyring-daemon --start --components=ssh)
        '';
      };
      direnv = {
        enable = true;
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
      ranger = {
        enable = true;
        package = pkgs.ranger;
      };
      starship = {
        enable = (if (builtins.pathExists("${config.home.homeDirectory}/.config/starship/starship.toml")) then true else false);
        settings = pkgs.lib.importTOML "${config.home.homeDirectory}/.config/starship/starship.toml";
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
    };
    xdg = {
      configFile = {
        "wezterm/colors.lua" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/wezterm/colors.lua"; };
        "wezterm/font.lua" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/wezterm/font.lua"; };
        "wezterm/keybinds.lua" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/wezterm/keybinds.lua"; };
        "wezterm/mousebinds.lua" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/wezterm/mousebinds.lua"; };
        "wezterm/wezterm.lua" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/wezterm/wezterm.lua"; };
        "nvim/init.lua" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/init.lua"; };
        "nvim/lazy-lock.json" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/lazy-lock.json"; };
        "nvim/.stylua.toml" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/.stylua.toml"; };
        "nvim/neovim.yml" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/neovim.yml"; };
        "nvim/lua" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/lua"; };
        "ranger/commands.py" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/ext/ranger/commands.py"; };
        "ranger/commands_full.py" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/ext/ranger/commands_full.py"; };
        "ranger/rc.conf" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/ext/ranger/rc.conf"; };
        "ranger/rifle.conf" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/ext/ranger/rifle.conf"; };
        "ranger/scope.sh" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/ext/ranger/scope.sh"; };
        "ranger/plugins/ranger_devicons/__init__.py" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/ext/ranger/plugins/ranger_devicons/__init__.py"; };
        "ranger/plugins/ranger_devicons/devicons.py" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/ext/ranger/plugins/ranger_devicons/devicons.py"; };
        "starship/starship.toml" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/starship/starship.toml"; };
      };
      desktopEntries = {
        "nvim" = {
          name = "nvim";
          comment = "Edit text files";
          icon = "nvim";
          exec = "${pkgs.wezterm}/bin/wezterm -e ${inputs.neovim-nightly-overlay.packages.${pkgs.system}.default}/bin/nvim %F";
          categories = [ "Application" ];
          terminal = false;
          mimeType = [ "text/plain" ];
        };
        "explorer" = {
          name = "explorer";
          comment = "TUI File Explorer";
          icon = "ranger";
          exec = "${pkgs.wezterm}/bin/wezterm -e ${pkgs.ranger}/bin/ranger %F";
          categories = [ "Application" ];
          terminal = false;
          #mimeType = [ "text/plain" ];
        };
      };
    };
  };
}
