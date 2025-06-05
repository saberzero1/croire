{ pkgs, ... }:
let
  eza = {
    ls = "${pkgs.eza}/bin/eza --icons --long --group-directories-first";
    lsa = "${pkgs.eza}/bin/eza --icons --long --all --group-directories-first";
    lsd = "${pkgs.eza}/bin/eza --icons --long --group-directories-first --tree";
    lsae = "${pkgs.eza}/bin/eza --icons --long --all --group-directories-first --tree";
    ll = "${pkgs.eza}/bin/eza --icons --long";
    la = "${pkgs.eza}/bin/eza --icons --long --all";
    lld = "${pkgs.eza}/bin/eza --icons --long --tree";
    lae = "${pkgs.eza}/bin/eza --icons --long --all --tree";
  };
  just = {
    j = "${pkgs.just}/bin/just --choose";
    gj = "${pkgs.just}/bin/just --global-justfile --choose";
  };
  vi = {
    vi = "${pkgs.neovim}/bin/nvim";
    vim = "${pkgs.neovim}/bin/nvim";
    vimdiff = "${pkgs.neovim}/bin/nvim -d";
  };
in
{
  home.shellAliases =
    {
      ts = "tmux-sessionizer";
      uuid = "uuidgen";
    }
    // eza
    // just
    // vi;
}
