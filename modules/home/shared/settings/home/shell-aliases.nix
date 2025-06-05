{ pkgs, ... }:
let
  eza = {
    ls = "${pkgs.eza} --icons --long --group-directories-first";
    lsa = "${pkgs.eza} --icons --long --all --group-directories-first";
    lsd = "${pkgs.eza} --icons --long --group-directories-first --tree";
    lsae = "${pkgs.eza} --icons --long --all --group-directories-first --tree";
    ll = "${pkgs.eza} --icons --long";
    la = "${pkgs.eza} --icons --long --all";
    lld = "${pkgs.eza} --icons --long --tree";
    lae = "${pkgs.eza} --icons --long --all --tree";
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
