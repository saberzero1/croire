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
	  LAZY = "/Users/${user}/share/lazy-nvim";
	  XDG_CONFIG_HOME = "/Users/${user}/config";
	  WEZTERM_CONFIG_FILE = "/Users/${user}/config/wezterm/wezterm.lua";
    WEZTERM_CONFIG_DIR = "/Users/${user}/config/wezterm";
    STARSHIP_CONFIG = "/Users/${user}/config/starship/starship.toml";
    ZDOTDIR = "/Users/${user}/config/zsh";
  };
}
