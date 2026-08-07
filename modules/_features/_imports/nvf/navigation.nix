{ pkgs, ... }: {
  programs.nvf.settings.vim = {
    navigation = {
      harpoon = {
        enable = true;
        mappings = {
          file1 = "<C-j>";
          file2 = "<C-k>";
          file3 = "<C-l>";
          file4 = "<C-;>";
          listMarks = "<C-e>";
          markFile = "<leader>a";
        };
      };
    };
    minimap = {
      minimap-vim = {
        enable = false;
      };
      codewindow = {
        enable = false;
      };
    };
    utility.snacks-nvim = {
      enable = true;
      setupOpts = {
        dashboard = {
          enabled = false;
        };
        bigfile = {
          enabled = true;
        };
        quickfile = {
          enabled = true;
        };
        terminal = { };
        indent = {
          enabled = true;
        };
        input = {
          enabled = true;
        };
        notifier = {
          enabled = false;
        };
        notify = {
          enabled = false;
        };
        scope = {
          enabled = true;
        };
        scroll = {
          enabled = true;
        };
        statuscolumn = {
          enabled = true;
        };
        toggle = {
          enabled = true;
        };
        words = {
          enabled = true;
        };
        picker = {
          enabled = false;
        };
      };
    };
    telescope = {
      enable = true;
      extensions = [
        {
          name = "yank_history";
          setup = {
            yank_history = { };
          };
        }
      ];
    };
  };
}
