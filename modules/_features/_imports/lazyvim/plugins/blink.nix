{
  programs.lazyvim.plugins.blink = ''
    return {
      "saghen/blink.cmp",
      opts = {
        keymap = {
          preset = "super-tab",
        },
      },
    }
  '';
}
