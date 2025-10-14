{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.svelte.enable = true;
    };

    extraPackages = with pkgs; [
      svelte-language-server
    ];
  };
}
