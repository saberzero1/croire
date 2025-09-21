{ lib, ... }:
let
  lua = lib.mkLuaInline;
in
{
  programs.nvf.settings.vim = {
    options = {
      autoindent = true;
      autowrite = true;
      clipboard = lua ''
        vim.env.SSH_TTY and "" or "unnamedplus"
      '';
      cmdheight = 3;
      completeopt = "menu,menuone,noselect";
      conceallevel = 2;
      confirm = true;
      cursorline = true;
      expandtab = true;
      /*
        fillchars = lua ''
          {
            foldopen = "",
            foldclose = "",
            fold = " ",
            foldsep = " ",
            diff = "╱",
            eob = " ",
          }
        '';
      */
      foldlevel = 99;
      formatexpr = "v:lua.require'conform'.formatexpr()";
      formatoptions = "jcroqlnt";
      grepformat = "%f:%l:%c:%m";
      grepprg = "rg --vimgrep";
      ignorecase = true;
      inccommand = "nosplit";
      jumpoptions = "view";
      laststatus = 3;
      linebreak = true;
      list = true;
      mouse = "a";
      number = true;
      pumblend = 10;
      pumheight = 10;
      relativenumber = true;
      ruler = true;
      scrolloff = 5;
      sessionoptions = "buffers,curdir,tabpages,winsize,help,globals,skiprtp,folds";
      shiftround = true;
      shiftwidth = 2;
      shortmess = lua ''
        vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
      '';
      showmode = false;
      sidescrolloff = 8;
      signcolumn = "yes";
      smartcase = true;
      smartindent = true;
      spelllang = "en_us,nl";
      splitbelow = true;
      splitkeep = "screen";
      splitright = true;
      # statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]];
      tabstop = 2;
      termguicolors = true;
      # undofile = true;
      undolevels = 10000;
      updatetime = 200;
      virtualedit = "block";
      wildmode = "longest:full,full";
      winminwidth = 5;
      wrap = false;
      # timeoutlen = 300;
      # tm = 300;
    };
    preventJunkFiles = true;
    searchCase = "smart";
    syntaxHighlighting = true;
    undoFile = {
      enable = true;
    };
  };
}
