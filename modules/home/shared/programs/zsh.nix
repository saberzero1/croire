{ pkgs, config, ... }:
{
  programs.zsh = {
    enable = true;
    package = pkgs.zsh;
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
    shellAliases = {
      uuid = "uuidgen";
      ll = "ls -l";
      ".." = "cd ..";
    };
    enableVteIntegration = true;
    initContent = ''
      # zoxide
      eval "$(zoxide init --cmd cd zsh)"
      #
      # atuin
      # eval "$(atuin init zsh --disable-up-arrow)"
      #
      # direnv
      eval "$(direnv hook zsh)"
      #
      # starship
      eval "$(starship init zsh)"
      #
      # thefuck replacement pay-respects
      eval $(pay-respects zsh --alias fuck --nocnf)
      #
      if [[ $(uname -m) == 'arm64' ]]; then
        # Aerospace on Silicon
        eval "$(/opt/homebrew/bin/brew shellenv)"
      else
        # Systemd on linux
        eval $(dbus-update-activation-environment --systemd --all)
      fi
      #
      # source shortcuts
      source "${config.home.homeDirectory}/.config/zsh/scripts/shortcuts"
      #
      # tmux
      bindkey -s "^F" "tmux-sessionizer\n"
    '';
    plugins = [
      {
        name = "zsh-autopair";
        src = pkgs.zsh-autopair;
        file = "share/zsh-autopair/zsh-autopair.zsh";
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      {
        name = "zsh-you-should-use";
        src = pkgs.zsh-you-should-use;
        file = "share/zsh-you-should-use/zsh-vi-mode.plugin.zsh";
      }
    ];
  };
}
