{ flake
, pkgs
, ...
}:
{
  imports = [
    flake.inputs.nvf.homeManagerModules.default
    ./nvf
  ];

  programs.nvf = {
    enable = true;
    defaultEditor = true;
    settings = {
      vim = {
        enableLuaLoader = true;
        package = pkgs.neovim;
        viAlias = true;
        vimAlias = true;
        withNodeJs = true;
        withPython3 = true;
        withRuby = true;
      };
    };
  };
}
