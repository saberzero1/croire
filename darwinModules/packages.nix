{ pkgs, ... }:

with pkgs; [
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
  neovim-unwrapped

  # Terminal
  ranger
  starship
  tmux
  wezterm
  zsh
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
  fd
  ffmpeg
  fzf
  gnumake
  jq
  just
  pandoc
  ripgrep
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
]
