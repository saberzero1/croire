{ pkgs, ... }:
{
  fonts = {
    #enableFontDir = true;
    packages = with pkgs; [
      monaspace
      nerd-fonts.monaspace
      fira-code-symbols
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      # borg-sans-mono #DroidSansMono
      nerd-fonts.droid-sans-mono
      nerd-fonts.mononoki
    ];
  };
}
