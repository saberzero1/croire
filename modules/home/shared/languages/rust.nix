{ pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        rustup
      ];
    };
  };
}
