{ ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    #vimdiffAlias = true;
    #nixpkgs.useGlobalPkgs = false;
    /*
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      package = pkgs.neovim;
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
      extraPackages = with pkgs; [
        alejandra
        python313Packages.black
        golangci-lint
        gopls
        gotools
        hadolint
        isort
        lua-language-server
        markdownlint-cli
        nil
        nixd
        nodePackages.bash-language-server
        nodePackages.prettier
        pyright
        ruff
        shellcheck
        shfmt
        stylua
        terraform-ls
        tflint
        vscode-langservers-extracted
        yaml-language-server
      ];
    */
  };
}
