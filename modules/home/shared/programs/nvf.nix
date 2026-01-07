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
        # enableLuaLoader = true;
        package = flake.inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
        viAlias = true;
        vimAlias = true;
        withNodeJs = true;
        withPython3 = true;
        python3Packages = [ "pynvim" ];
        withRuby = true;
        preventJunkFiles = true;
        searchCase = "smart";
        syntaxHighlighting = true;
        undoFile = {
          enable = true;
        };
      };
    };
  };
}
