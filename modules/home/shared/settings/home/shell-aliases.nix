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
  tmux = {
    t1 = "tmux select-window -t 1 || tmux new-window -t 1 -n 'scratch' -c '#{pane_current_path}' $SHELL";
    t2 = "tmux select-window -t 2 || tmux new-window -t 2 -n 'editor' -c '#{pane_current_path}' nvim";
    t3 = "tmux select-window -t 3 || tmux new-window -t 3 -n 'watcher' -c '#{pane_current_path}' $SHELL";
    t4 = "tmux select-window -t 4 || tmux new-window -t 4 -n 'remote' -c '#{pane_current_path}' $SHELL";
    t5 = "tmux select-window -t 5 || tmux new-window -t 5 -n 'git' -c '#{pane_current_path}' lazygit";
    t6 = "tmux select-window -t 6 || tmux new-window -t 6 -c '#{pane_current_path}'";
    t7 = "tmux select-window -t 7 || tmux new-window -t 7 -c '#{pane_current_path}'";
    t8 = "tmux select-window -t 8 || tmux new-window -t 8 -c '#{pane_current_path}'";
    t9 = "tmux select-window -t 9 || tmux new-window -t 9 -c '#{pane_current_path}'";
    t0 = "tmux select-window -t 10 || tmux new-window -t 10 -c '#{pane_current_path}'";
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
    // tmux
    // vi;
}
