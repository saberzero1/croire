{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.yaml.enable = true;
    };

    extraPackages = with pkgs; [
      yamllint
      yq
    ];
  };
}
