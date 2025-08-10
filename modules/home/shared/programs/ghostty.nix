{ pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin isLinux;
  packageTarget = if isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
  extraSettings =
    if isDarwin then
      {
        font-size = 20;
        window-theme = "system";
        macos-option-as-alt = true;
        macos-auto-secure-input = true;
        macos-secure-input-indication = true;
      }
    else
      {
        font-size = 18;
      };
in
{
  programs.ghostty = {
    enable = isLinux;
    package = packageTarget;
    settings = {
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

      theme = "dark:tokyonight-storm,light:tokyonight-day";
      shell-integration = "zsh";
    }
    // extraSettings;
  };
}
