{ flake, pkgs, ... }:
{
  # Programs natively supported by home-manager.
  # They can be configured in `programs.*` instead of using home.packages.
  programs = {
    zsh = {
      enable = true;
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
      '';
      profileExtra = ''
        # Aerospace on Silicon
        eval "$(/opt/homebrew/bin/brew shellenv)"
      '';
    };
  };
}
