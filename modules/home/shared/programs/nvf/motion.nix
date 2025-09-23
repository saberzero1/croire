{
  programs.nvf.settings.vim.lazy.plugins."flash-nvim" = {
    enabled = true;
    lazy = true;
    package = "flash-nvim";
    setupModule = "flash";
    keys = [
      {
        mode = [
          "n"
          "o"
          "x"
        ];
        key = "s";
        action = "<cmd>lua require('flash').jump()<cr>";
        desc = "Flash: Jump";
      }
      {
        mode = [
          "n"
          "o"
          "x"
        ];
        key = "S";
        action = "<cmd>lua require('flash').treesitter()<cr>";
        desc = "Flash: Treesitter";
      }
      {
        mode = "o";
        key = "r";
        action = "<cmd>lua require('flash').remote()<cr>";
        desc = "Flash: Remote";
      }
      {
        mode = [
          "o"
          "x"
        ];
        key = "R";
        action = "<cmd>lua require('flash').treesitter_search()<cr>";
        desc = "Flash: Treesitter Search";
      }
      {
        mode = "c";
        key = "<c-s>";
        action = "<cmd>lua require('flash').toggle()<cr>";
        desc = "Flash: Toggle";
      }
      {
        mode = [
          "n"
          "o"
          "x"
        ];
        key = "<c-space>";
        action = "<cmd>lua function() require('flash').treesitter({ actions = { ['<c-space>'] = 'next', ['<BS>'] = 'prev' } }) end<cr>";
        desc = "Flash: Treesitter Incremental Selection";
      }
    ];
    setupOpts = {
      jump = {
        autojump = true;
      };
    };
  };
}
