{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty;
    settings = {
      font-size = 18;
      font-family = "Monaspace Neon";
      font-family-bold = "Monaspace Xenon";
      font-family-italic = "Monaspace Radon";
      font-family-bold-italic = "Monaspace Krypton";
      font-feature = [
        "+calt"
        "+clig"
        "+liga"
        "+dlig"
        "+ss01"
        "+ss02"
        "+ss03"
        "+ss04"
        "+ss05"
        "+ss06"
        "+ss07"
        "+ss08"
        "+ss09"
        "+ss10"
        "+ss11"
        "+ss12"
        "+ss13"
        "+ss14"
        "+ss15"
      ];

      theme = "dark:TokyoNight Storm,light:TokyoNight Day";
      shell-integration = "zsh";
    };
  };
}
