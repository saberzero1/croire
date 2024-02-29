{
  description = "NixOS Configuration.";
  inputs = {
    nixpkgs.url = "flake:nixpkgs/nixpkgs-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
    home-manager.url = "flake:home-manager";
    home-manager-2.url = "flake:home-manager";
  };
  outputs = inputs:
    let
      flakeContext = {
        inherit inputs;
      };
    in
    {
      homeConfigurations = {
        saberzero1 = import ./homeConfigurations/saberzero1.nix flakeContext;
      };
      homeModules = {
        applications = import ./homeModules/applications.nix flakeContext;
        browser = import ./homeModules/browser.nix flakeContext;
        console = import ./homeModules/console.nix flakeContext;
        desktop = import ./homeModules/desktop.nix flakeContext;
        development = import ./homeModules/development.nix flakeContext;
        git = import ./homeModules/git.nix flakeContext;
        javascript = import ./homeModules/javascript.nix flakeContext;
        neovim = import ./homeModules/neovim.nix flakeContext;
        programming_languages = import ./homeModules/programming_languages.nix flakeContext;
        python = import ./homeModules/python.nix flakeContext;
        ruby = import ./homeModules/ruby.nix flakeContext;
        security = import ./homeModules/security.nix flakeContext;
        system = import ./homeModules/system.nix flakeContext;
        utils = import ./homeModules/utils.nix flakeContext;
        vscodium = import ./homeModules/vscodium.nix flakeContext;
        workflow = import ./homeModules/workflow.nix flakeContext;
      };
      nixosConfigurations = {
        croire = import ./nixosConfigurations/croire.nix flakeContext;
        laptop-hp = import ./nixosConfigurations/laptop-hp.nix flakeContext;
      };
      nixosModules = {
        applications = import ./nixosModules/applications.nix flakeContext;
        browser = import ./nixosModules/browser.nix flakeContext;
        console = import ./nixosModules/console.nix flakeContext;
        desktop = import ./nixosModules/desktop.nix flakeContext;
        development = import ./nixosModules/development.nix flakeContext;
        git = import ./nixosModules/git.nix flakeContext;
        javascript = import ./nixosModules/javascript.nix flakeContext;
        neovim = import ./nixosModules/neovim.nix flakeContext;
        programming_languages = import ./nixosModules/programming_languages.nix flakeContext;
        python = import ./nixosModules/python.nix flakeContext;
        ruby = import ./nixosModules/ruby.nix flakeContext;
        security = import ./nixosModules/security.nix flakeContext;
        system = import ./nixosModules/system.nix flakeContext;
        utils = import ./nixosModules/utils.nix flakeContext;
        vscodium = import ./nixosModules/vscodium.nix flakeContext;
        workflow = import ./nixosModules/workflow.nix flakeContext;
      };
    };
}
