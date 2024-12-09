{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs.nodePackages; [
      live-server
      nodejs
      typescript
      prettier
      eslint_d
      svelte-language-server
      typescript-language-server
      ts-node
      sass
      serve
      npm
    ];
  };
}
