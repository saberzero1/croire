{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.elixir = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
      };
    };

    extraPackages = with pkgs; [
      elixir
      elixir-ls
    ];
  };
}
