{ pkgs, ... }:
{
  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages = with pkgs; [
    # Unix tools
    ripgrep # Better `grep`
    fd
    sd
    tree
    gnumake

    # Nix dev
    cachix
    nil # Nix language server
    nix-info
    nixpkgs-fmt

    # Dev
    tmate

    # On ubuntu, we need this less for `man home-configuration.nix`'s pager to
    # work.
    less

    # Core
    coreutils
    gcc
    killall
    openssh
    sqlite
    wget
    zip

    # Development
    direnv
    nix-direnv
    gh
    #neovim-unwrapped
    #inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
    neovim

    # Terminal
    ranger
    starship
    tmux
    wezterm
    #inputs.wezterm.packages.${pkgs.system}.default
    zsh
    zsh-autopair
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
    zsh-vi-mode
    zsh-you-should-use

    # Fonts
    nerd-fonts.monaspace
    nerd-fonts.fira-code
    fira-code-symbols
    nerd-fonts.fira-mono
    nerd-fonts.droid-sans-mono #DroidSansMono
    nerd-fonts.mononoki

    # Security
    age
    age-plugin-yubikey
    gnupg

    # Javascript
    nodePackages.live-server
    nodePackages.prettier
    nodePackages.npm
    nodejs

    # Utility
    ffmpeg
    fzf
    jq
    just
    pandoc
    ripgrep-all
    rsync
    thefuck
    unrar
    unzip
    zoxide

    # Python
    black
    python3
    virtualenv

    # Mac
    fswatch
    dockutil
    aerospace
  ];

  # Programs natively supported by home-manager.
  # They can be configured in `programs.*` instead of using home.packages.
  programs = {
    # Better `cat`
    bat.enable = true;
    # Type `<ctrl> + r` to fuzzy search your shell history
    fzf.enable = true;
    jq.enable = true;
    # Install btop https://github.com/aristocratos/btop
    btop.enable = true;
  };
}
