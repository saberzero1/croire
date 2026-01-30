{ lib, ... }:
{
  # Disable Nix-managed espanso service on macOS.
  # Espanso is installed via Homebrew to maintain stable accessibility permissions.
  # Nix-installed binaries have changing store paths that cause macOS to revoke
  # accessibility permissions on every rebuild.
  # See: https://github.com/nix-community/home-manager/issues/8179
  #
  # Homebrew Espanso manages its own LaunchAgent via `espanso service register`.
  services.espanso.enable = lib.mkForce false;
}
