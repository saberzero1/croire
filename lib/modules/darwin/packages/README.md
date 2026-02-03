# Darwin Package Management

Manages Homebrew packages, casks, Mac App Store apps, and taps for macOS.

## Structure

- `casks/` - GUI applications installed via Homebrew Casks
- `formulae/` - Command-line tools and packages
- `masApps/` - Mac App Store applications
- `taps/` - Third-party Homebrew repositories

## Features

- Configures nix-homebrew for declarative Homebrew management
- Sets up automatic updates and cleanup policies
- Integrates Homebrew with nix-darwin
