{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    home = {
      packages = [
        # For home-manager
        nixvim.homeManagerModules.nixvim
        # For NixOS
        # nixvim.nixosModules.nixvim
        # For nix-darwin
        # nixvim.nixDarwinModules.nixvim
      ];
    };
    programs = {
      nixvim = {
        enable = true;
        clipboard = {
          register = "unnamedplus";
          providers =
            { null
            }
              };
              options = {
              number = true;         # Show line numbers
              relativenumber = true; # Show relative line numbers
              shiftwidth = 4;        # Tab width should be 2
              };
              colorschemes = {
              tokyonight = {
              enable = true;
              style = "storm";
              styles = {
              comments = {
              italic = true;
              }
              floats = "dark";
              functions = {
              null
              }
              keywords = {
              italic = true;
              }
              sidebars = "dark";
              variables = {
              null
              }
              }
              }
              };
              plugins = {
              lightline = {
              enable = true;
              }
              };
              extraPlugins = with pkgs.vimPlugins; [
              vim-nix
              ];
              globals = {
              mapleader = " ";
              };
              # https://github.com/nix-community/nixvim?tab=readme-ov-file#key-mappings
              keymaps = [
              {
              mode = "n";
              key = ";";
              action = ":";
              }
              ];
              extraConfigLua = ''
      -- Print a little welcome message when nvim is opened!
      print("Hello world!")
    '';
              };
              };
              };
              }
