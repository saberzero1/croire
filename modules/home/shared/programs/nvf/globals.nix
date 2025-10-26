{
  programs.nvf.settings.vim.globals = {
    editorconfig = true;
    mapleader = " ";
    maplocalleader = "\\";
    autoformat = true;
    snacks_animate = true;
    lazyvim_picker = "telescope";
    lazyvim_cmp = "blink.cmp";
    ai_cmp = true;
    root_spec = [
      "lsp"
      [
        ".git"
        "lua"
      ]
      "cwd"
    ];
    root_lsp_ignore = [
      "copilot"
    ];
    deprecation_warnings = false;
    trouble_lualine = true;
    markdown_recommended_style = 0;
  };
}
