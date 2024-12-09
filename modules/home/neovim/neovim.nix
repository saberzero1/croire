{
  defaultEditor = true;
  package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  viAlias = true;
  vimAlias = true;
  withNodeJs = true;
  withPython3 = true;
  withRuby = true;
}
