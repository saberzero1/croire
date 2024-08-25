{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.oh-my-zsh
        pkgs.zsh
        pkgs.zsh-you-should-use
        pkgs.zsh-vi-mode
        pkgs.oh-my-posh
        pkgs.wezterm
      ];
    };
    programs = {
      oh-my-posh = {
        enable = true;
        enableZshIntegration = true;
        package = pkgs.oh-my-posh;
        settings = { };
        useTheme = "tokyonight_storm";
      };
      zsh = {
        enable = true;
        enableCompletion = true;
        enableLsColors = true;
        ohMyZsh = {
          enable = true;
        };
      };
      wezterm = {
        enable = true;
        enableZshIntegration = true;
        enableBashIntegration = true;
        extraConfig = ''
          return {
            font = wezterm.font("Fira Code"),
            font_size = 16.0,
            color_scheme = "tokyonight_storm",
            keys = {
              {key="n", mods="SHIFT|CTRL", action="ToggleFullScreen"},
            }
          }
        '';
      };
    };
    users = {
      defaultUserShell = pkgs.wezterm;
    };
  };
}
