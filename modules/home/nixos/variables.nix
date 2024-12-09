{ ... }:
{
  home.sessionVariables = {
    # DEFAULT_BROWSER = "${pkgs.wavebox}/bin/wavebox";
    EDITOR = "nvim";
    VISUAL = "nvim";
    # TERM = "wezterm";
	          # TERM = "${pkgs.wezterm}/Applications/Wezterm.app/";
    # BROWSER = "${pkgs.wavebox}/bin/wavebox";
    # LAZY = "${config.home.homeDirectory}/.local/share/lazy-nvim";
	  LAZY = "$HOME/share/lazy-nvim";
	  XDG_CONFIG_HOME = "$HOME/config";
	  WEZTERM_CONFIG_FILE = "$HOME/config/wezterm/wezterm.lua";
    WEZTERM_CONFIG_DIR = "$HOME/config/wezterm";
    STARSHIP_CONFIG = "$HOME/config/starship/starship.toml";
    ZDOTDIR = "$HOME/config/zsh";
  };
}
