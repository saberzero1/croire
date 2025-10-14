{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.markdown.enable = true;
    };

    extraPackages = with pkgs; [
      pandoc
      prettier
      markdownlint-cli
    ];
  };
}
