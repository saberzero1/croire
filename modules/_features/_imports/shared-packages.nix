# Shared system packages for Darwin and NixOS
# Returns attribute sets that can be used with `environment.systemPackages`
{ pkgs }:
{
  # Kubernetes tools
  kubernetes = with pkgs; [
    k9s
    kubernetes-helm
    kubernetes-polaris
    kubectl
    kind
    kail
    helmsman
    helmfile
    helm-docs
  ];

  # Development tools (shared across platforms)
  devTools = with pkgs; [
    tree-sitter
    sqlfluff
    viu
    chafa
    comment-checker
    haskellPackages.hoogle
    fh
    bun
    go
    ispell
    lazynpm
    lazycli
  ];

  # Security & SSH
  security = with pkgs; [
    gnupg
    sshpass
  ];

  # Git tooling
  git = with pkgs; [
    diff-so-fancy
    gh
    lazygit
    gitFull
  ];
}
