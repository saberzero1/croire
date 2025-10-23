{ pkgs, ... }:
{
  imports = builtins.map (fn: ./${fn}) (
    builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir ./.))
  );

  programs.lazyvim.extraPackages = with pkgs.vimPlugins; [
    nvim-treesitter-textobjects
  ];
}
