{ pkgs, ... }:
let
  plugin = pkgs.vimPlugins;
in
{
  programs.nvf.settings.vim = {
    keymaps = [ ];
    lazy.plugins = {
      enabled = true;
      "${plugin.unimpaired-nvim.pname}" = {
        package = plugin.unimpaired-nvim;
        setupModule = "unimpaired";
        setupOpts = {
          keymaps = {
            # space
            blank_above = false;
            blank_below = false;
            # a, A, ^A
            next = false;
            previous = false;
            first = false;
            last = false;
            # b, B, ^B
            bnext = false;
            bprevious = false;
            bfirst = false;
            blast = false;
            # q, Q, ^Q
            cnext = false;
            cprevious = false;
            cfirst = false;
            clast = false;
            cnfile = false;
            cpfile = false;
            # l, L, ^L
            lnext = false;
            lprevious = false;
            lfirst = false;
            llast = false;
            lnfile = false;
            lpfile = false;
            # t, t, ^T
            tnext = false;
            tprevious = false;
            tfirst = false;
            tlast = false;
            ptnext = false;
            ptprevious = false;
          };
        };
      };
    };
  };
}
