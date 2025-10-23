{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.ruby = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
      };
    };

    extraPackages = with pkgs; [
      ruby
    ];
  };
}
