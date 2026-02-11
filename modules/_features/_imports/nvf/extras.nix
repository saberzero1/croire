{ pkgs, ... }:
{
  programs.nvf.settings.vim.extraPackages = with pkgs; [
    coreutils # provides grealpath for yazi
    fd
    fzf
    lazygit
    ripgrep
    rustup
    sqlfluff

    # Snacks.image dependencies
    imagemagick # magick/convert - image conversion (required for non-PNG images)
    ghostscript # gs - PDF rendering
    tectonic # LaTeX math expression rendering
    mermaid-cli # mmdc - Mermaid diagram rendering
  ];
}
