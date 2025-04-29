{ pkgs, ... }:
{
  system = {
    activationScripts = {
      postActivation.text = ''
        echo "Setting tmux-sessionizer permissions"
      '';
    };
  };
}
