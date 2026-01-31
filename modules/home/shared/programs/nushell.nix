{ pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    package = pkgs.nushell;

    # ─────────────────────────────────────────────────────────────────────────────
    # Configuration Files
    # ─────────────────────────────────────────────────────────────────────────────
    # Use external file for config.nu
    # configFile.source = ./config.nu;

    # Use external file for env.nu
    # envFile.source = ./env.nu;

    # Use external file for login.nu
    # loginFile.source = ./login.nu;

    # ─────────────────────────────────────────────────────────────────────────────
    # Settings (converted to $env.config)
    # ─────────────────────────────────────────────────────────────────────────────
    settings = {
      show_banner = false;

      # History settings
      # history = {
      #   max_size = 100000;
      #   sync_on_enter = true;
      #   file_format = "sqlite";  # "plaintext" or "sqlite"
      #   isolation = false;
      # };

      # Completions
      # completions = {
      #   case_sensitive = false;
      #   quick = true;
      #   partial = true;
      #   algorithm = "fuzzy";  # "prefix" or "fuzzy"
      #   sort = "smart";  # "smart" or "alphabetical"
      #   external = {
      #     enable = true;
      #     max_results = 100;
      #     # completer = ...;  # Custom completer function
      #   };
      # };

      # Table display
      # table = {
      #   mode = "rounded";  # "basic", "compact", "compact_double", "light",
      #                      # "thin", "with_love", "rounded", "reinforced",
      #                      # "heavy", "none", "psql", "markdown", "dots"
      #   index_mode = "always";  # "always", "never", "auto"
      #   show_empty = true;
      #   padding = { left = 1; right = 1; };
      #   trim = {
      #     methodology = "wrapping";  # "wrapping" or "truncating"
      #     wrapping_try_keep_words = true;
      #     truncating_suffix = "...";
      #   };
      #   header_on_separator = false;
      #   abbreviated_row_count = 10;
      # };

      # Error display
      # error_style = "fancy";  # "fancy" or "plain"

      # Filesize display
      # filesize = {
      #   metric = false;  # true for KB/MB, false for KiB/MiB
      #   format = "auto";  # "b", "kb", "kib", "mb", "mib", "gb", "gib", "tb", "tib", "pb", "pib", "eb", "eib", "auto"
      # };

      # Datetime format
      # datetime_format = {
      #   normal = "%a, %d %b %Y %H:%M:%S %z";
      #   table = "%m/%d/%y %I:%M:%S%p";
      # };

      # Footer mode
      # footer_mode = "25";  # "always", "never", "auto", or row count

      # Float precision
      # float_precision = 2;

      # Buffer editor
      # buffer_editor = "hx";

      # Use ANSI colors
      # use_ansi_coloring = true;

      # Bracketed paste
      # bracketed_paste = true;

      # Edit mode
      # edit_mode = "emacs";  # "emacs" or "vi"

      # Shell integration
      # shell_integration = {
      #   osc2 = true;
      #   osc7 = true;
      #   osc8 = true;
      #   osc9_9 = false;
      #   osc133 = true;
      #   osc633 = true;
      #   reset_application_mode = true;
      # };

      # Rendering
      # render_right_prompt_on_last_line = false;

      # Hooks
      # hooks = {
      #   pre_prompt = [];
      #   pre_execution = [];
      #   env_change = { };
      #   display_output = "if (term size).columns >= 100 { table -e } else { table }";
      #   command_not_found = { };
      # };

      # Menus
      # menus = [];

      # Keybindings
      # keybindings = [];

      # Cursor shape
      # cursor_shape = {
      #   emacs = "line";  # "block", "underscore", "line", "blink_block", "blink_underscore", "blink_line", "inherit"
      #   vi_insert = "block";
      #   vi_normal = "underscore";
      # };

      # Color config
      # color_config = { };

      # Use ls colors
      # use_ls_colors = true;

      # RM always trash
      # rm = {
      #   always_trash = false;
      # };

      # Recursion limit
      # recursion_limit = 50;

      # Plugin GC
      # plugin_gc = {
      #   default = {
      #     enabled = true;
      #     stop_after = "10sec";
      #   };
      #   plugins = { };
      # };
    };

    # ─────────────────────────────────────────────────────────────────────────────
    # Extra Configuration (appended to config.nu)
    # ─────────────────────────────────────────────────────────────────────────────
    extraConfig = ''
      # ───────────────────────────────────────────────────────────────────────────
      # Custom configuration
      # ───────────────────────────────────────────────────────────────────────────

      # zoxide integration
      # source ~/.cache/zoxide/init.nu

      # Custom PATH additions
      # $env.PATH = ($env.PATH | split row (char esep) | prepend ($env.HOME | path join ".local/bin"))

      # Keybindings
      # $env.config.keybindings = ($env.config.keybindings | append {
      #   name: tmux_sessionizer
      #   modifier: control
      #   keycode: char_f
      #   mode: [emacs vi_normal vi_insert]
      #   event: { send: executehostcommand cmd: "tmux-sessionizer" }
      # })
    '';

    # ─────────────────────────────────────────────────────────────────────────────
    # Extra Environment (appended to env.nu)
    # ─────────────────────────────────────────────────────────────────────────────
    extraEnv = ''
      # ───────────────────────────────────────────────────────────────────────────
      # Environment setup
      # ───────────────────────────────────────────────────────────────────────────

      # Editor
      # $env.EDITOR = "hx"
      # $env.VISUAL = "hx"

      # XDG directories
      # $env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")
      # $env.XDG_DATA_HOME = ($env.HOME | path join ".local/share")
      # $env.XDG_CACHE_HOME = ($env.HOME | path join ".cache")

      # NU_LIB_DIRS for custom modules
      # $env.NU_LIB_DIRS = [
      #   ($env.HOME | path join ".config/nushell/scripts")
      #   ($env.HOME | path join ".local/share/nushell")
      # ]

      # NU_PLUGIN_DIRS for plugins
      # $env.NU_PLUGIN_DIRS = [
      #   ($env.HOME | path join ".config/nushell/plugins")
      # ]
    '';

    # ─────────────────────────────────────────────────────────────────────────────
    # Extra Login (appended to login.nu)
    # ─────────────────────────────────────────────────────────────────────────────
    extraLogin = ''
      # ───────────────────────────────────────────────────────────────────────────
      # Login shell configuration
      # ───────────────────────────────────────────────────────────────────────────

      # Commands to run on login shell
    '';

    # ─────────────────────────────────────────────────────────────────────────────
    # Shell Aliases
    # ─────────────────────────────────────────────────────────────────────────────
    shellAliases = {
      # Common aliases
      # ll = "ls -l";
      # la = "ls -la";
      # l = "ls";
      # g = "git";
      # vi = "hx";
      # vim = "hx";

      # Modern replacements
      # cat = "bat";
      # find = "fd";
      # grep = "rg";
      # top = "btop";
    };

    # ─────────────────────────────────────────────────────────────────────────────
    # Environment Variables
    # ─────────────────────────────────────────────────────────────────────────────
    environmentVariables = {
      SHELL = "${pkgs.nushell}/bin/nu";
      # Example environment variables (set as nushell values)
      # FOO = "bar";
      # SOME_NUMBER = 42;
    };

    # ─────────────────────────────────────────────────────────────────────────────
    # Plugins
    # ─────────────────────────────────────────────────────────────────────────────
    # Available plugins (uncomment as needed):
    # plugins = with pkgs.nushellPlugins; [
    #   formats      # Support for various data formats (csv, json, etc.)
    #   gstat        # Git status in nushell
    #   polars       # DataFrame operations
    #   query        # SQL-like querying
    #   skim         # Fuzzy finder integration
    # ];
  };
}
