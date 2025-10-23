{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.rust = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
      };
    };

    extraPackages = with pkgs; [
      rustup
      cargo
      rust-analyzer
      rustfmt
      clippy
    ];
  };
}
