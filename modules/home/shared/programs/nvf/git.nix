{ ... }:
let
  cmd = command: key: {
    action = "<cmd>Git ${command}<CR>";
    desc = "Git ${command}";
    key = "<leader>g${key}";
    mode = "n";
  };
in
{
  programs.nvf.settings.vim = {
    git = {
      gitsigns = {
        enable = true;
        mappings = {
          blameLine = null;
          diffProject = null;
          diffThis = null;
          nextHunk = null;
          previousHunk = null;
          previewHunk = null;
          resetBuffer = null;
          resetHunk = null;
          stageBuffer = null;
          stageHunk = null;
          toggleBlame = null;
          toggleDeleted = null;
          undoStageHunk = null;
        };
      };
      vim-fugitive = {
        enable = true;
      };
    };
    binds.whichKey.register = {
      "<leader>g" = "+Git";
      "<leader>h" = null;
    };
    keymaps = [
      (cmd "diff" "d")
      (cmd "status" "s")
    ];
  };
}
