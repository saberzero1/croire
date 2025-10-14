{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.typescript.enable = true;
    };

    extraPackages = with pkgs; [
      nodejs_latest
      yarn
      typescript
      deno
      prettier
      eslint_d
      eslint
      bun
    ];
  };
}
