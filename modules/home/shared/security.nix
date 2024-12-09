{ pkgs, ... }:
{
  home.packages = with pkgs; [
    diff-so-fancy
    gh
    lazygit
    git
    gnupg
    sshpass
  ];
  programs = {
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
  };
}
