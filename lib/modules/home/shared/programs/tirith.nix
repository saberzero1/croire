{
  pkgs,
  config,
  lib,
  ...
}:
{
  # tirith: Terminal security - guards against homograph attacks, ANSI injection, pipe-to-shell attacks
  # https://github.com/sheeki03/tirith

  home.packages = [ pkgs.tirith ];

  # Bash integration
  programs.bash.initExtra = lib.mkIf config.programs.bash.enable ''
    # tirith - terminal security
    eval "$(${pkgs.tirith}/bin/tirith init)"
  '';

  # Zsh integration - add to initContent for shell hooks
  programs.zsh.initContent = lib.mkIf config.programs.zsh.enable ''
    # tirith - terminal security
    eval "$(${pkgs.tirith}/bin/tirith init)"
  '';

  # Fish integration
  programs.fish.interactiveShellInit = lib.mkIf config.programs.fish.enable ''
    # tirith - terminal security
    ${pkgs.tirith}/bin/tirith init | source
  '';

  # Nushell integration - use pre_execution hook to check commands before execution
  programs.nushell.extraConfig = lib.mkIf config.programs.nushell.enable ''
    # ───────────────────────────────────────────────────────────────────────────
    # tirith - terminal security
    # Guards against homograph attacks, ANSI injection, pipe-to-shell attacks
    # ───────────────────────────────────────────────────────────────────────────

    # Define tirith check command
    def --env tirith-check [cmd: string] {
      let result = (${pkgs.tirith}/bin/tirith check --shell posix -- $cmd | complete)
      if $result.exit_code == 1 {
        # Command blocked - return error to prevent execution
        error make { msg: "tirith: command blocked" }
      }
      # exit_code 0 = allow, exit_code 2 = warn (already printed to stderr)
    }

    # Add pre_execution hook for tirith
    $env.config.hooks.pre_execution = ($env.config.hooks.pre_execution | default [] | append {||
      # Get the current commandline being executed
      let cmd = (commandline)
      if ($cmd | str trim | is-not-empty) {
        # Run tirith check - if it returns exit code 1, the command is blocked
        let result = (do { ${pkgs.tirith}/bin/tirith check --shell posix -- $cmd } | complete)
        if $result.exit_code == 1 {
          # Print block message (already printed by tirith) and clear the line
          commandline edit ""
        }
      }
    })
  '';
}
