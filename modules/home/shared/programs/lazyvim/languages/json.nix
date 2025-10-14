{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.json.enable = true;
    };

    extraPackages = with pkgs; [
      jq
    ];
  };
}
