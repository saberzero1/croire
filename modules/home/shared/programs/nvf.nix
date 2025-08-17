{ flake
, pkgs
, lib
, ...
}:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    flake.inputs.nvf.homeManagerModules.default
    ./nvf
  ];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        enableLuaLoader = true;
        package = flake.inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
        viAlias = true;
        vimAlias = true;
      };
    };
  };
}
