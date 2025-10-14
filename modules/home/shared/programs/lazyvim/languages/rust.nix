{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.rust.enable = true;
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
