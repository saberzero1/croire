{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.elixir.enable = true;
    };

    extraPackages = with pkgs; [
      elixir
      elixir-ls
    ];
  };
}
