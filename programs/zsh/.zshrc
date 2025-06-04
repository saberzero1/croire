# zoxide
eval "$(zoxide init --cmd cd zsh)"

# atuin
# eval "$(atuin init zsh --disable-up-arrow)"

# direnv
eval "$(direnv hook zsh)"

# starship
eval "$(starship init zsh)"

# thefuck replacement pay-respects
eval "$(pay-respects zsh --alias fuck --nocnf)"

# Aerospace on Silicon
if [[ $(uname -m) == 'arm64' ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# tmux
bindkey -s ^f "tmux-sessionizer\n"
