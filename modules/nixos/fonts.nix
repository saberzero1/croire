{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    enableGhostscriptFonts = true;
    fontDir = {
      enable = true;
    };
    fontconfig = {
      defaultFonts = {
        monospace = [
          "Monaspace Neon"
        ];
      };
      enable = true;
    };
    packages = with pkgs; [
      fira-code
      monaspace
      nerd-fonts.monaspace
      fira-code-symbols
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      nerd-fonts.droid-sans-mono
      nerd-fonts.mononoki
    ];
  };
}
