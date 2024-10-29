{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  imports = [
    #inputs.self.homeModules.neovim
    inputs.self.homeModules.vscodium
  ];
  config = {
    programs = {
      zed-editor = {
        enable = true;
      };
    };
    editorconfig = {
      enable = true;
      settings = {
        "*" = {
          charset = "utf-8";
          end_of_line = "lf";
          trim_trailing_whitespace = true;
          insert_final_newline = true;
          max_line_width = 79;
          indent_style = "space";
          indent_size = 2;
        };
      };
    };
  };
}
