{ pkgs, ... }:
{
  # Add nushell to the list of allowed shells
  environment.shells = with pkgs; [
    bashInteractive
    zsh
    nushell
  ];

  # Set nushell as the default shell for new users
  # Note: This only affects NEW users created through nix-darwin
  # For existing users, run: chsh -s /run/current-system/sw/bin/nu
  programs.bash.enable = true;
  programs.zsh.enable = true;

  # Enable nushell system-wide
  # The user's default shell must be changed manually:
  #   sudo chsh -s /run/current-system/sw/bin/nu <username>
  # Or add to /etc/shells and use:
  #   chsh -s $(which nu)
  environment.systemPackages = with pkgs; [
    nushell
  ];

  # Activation script to ensure nushell is in /etc/shells
  system.activationScripts.postActivation.text = ''
    # Ensure nushell is in /etc/shells
    if ! grep -q "/run/current-system/sw/bin/nu" /etc/shells; then
      echo "/run/current-system/sw/bin/nu" | sudo tee -a /etc/shells > /dev/null
    fi
  '';
}
