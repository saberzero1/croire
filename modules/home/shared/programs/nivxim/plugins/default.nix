{ ... }:
{
  imports =
    builtins.map (fn: ./${fn})
      (
        builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir ./.))
      )
    ++ [
      ./ai
      ./completion
      ./debug
      ./editor
      ./git
      ./lang
      ./lsp
      ./snacks
      ./themes
      ./treesitter
      ./ui
    ];
  config = {
    globals = {
      mapleader = " ";
      maplocalleader = "\\";
      have_nerd_fonts = true;
    };
    opts = {
      termguicolors = true;
      number = true;
      relativenumber = true;
      mouse = "a";
      showmode = false;
      breakindent = true;
      undofile = true;
      ignorecase = true;
      smartcase = true;
      updatetime = 250;
      timeoutlen = 300;
      splitright = true;
      splitbelow = true;
      list = true;
      listchars = {
        tab = "» ";
        trail = "·";
        nbsp = "␣";
      };
      inccommand = "split";
      cursorline = true;
      cursorlineopt = "both";
      cursorcolumn = true;
      colorcolum = "80";
      scrolloff = 5;
      background = "dark";
    };
  };
}
