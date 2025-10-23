{ pkgs, ... }:
{
  programs.lazyvim = {
    extras = {
      lang.markdown = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
      };
    };

    extraPackages =
      with pkgs;
      [
        pandoc
        prettier
        markdownlint-cli
        markdownlint-cli2
      ]
      ++ (with pkgs.vimPlugins; [
        vim-markdown-toc
      ]);
  };
}
