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
    eza

    # Nix dev
    cachix
    nil # Nix language server
    nix-info
    nixpkgs-fmt
    omnix

    # Dev
    tmate

    # On ubuntu, we need this less for `man home-configuration.nix`'s pager to
    # work.
    less

    # Core
    #coreutils
    coreutils-full
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
    gitFull
    diff-so-fancy
    neovim

    # Terminal
    ranger
    starship
    tmux
    fpp
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
    nerd-fonts.droid-sans-mono
    nerd-fonts.mononoki

    # Security
    age
    ssh-to-age
    age-plugin-yubikey
    yubikey-agent
    yubikey-manager
    gnupg

    # Terminal
    pay-respects

    # Javascript
    # nodejs

    # Utility
    ffmpeg-full
    fzf
    jq
    just
    pandoc
    ripgrep-all
    rsync
    unrar
    unzip
    zoxide

    # Python
    python313Packages.black
    python313Full
    virtualenv

    # Extra
    fastfetch
    gnuplot

    # Privacy
    tor
    libressl
    # playwright-driver
  ];
}
