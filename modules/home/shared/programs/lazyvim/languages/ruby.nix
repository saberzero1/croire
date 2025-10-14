{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.ruby.enable = true;
    };

    extraPackages = with pkgs; [
      ruby
    ];
  };
}
