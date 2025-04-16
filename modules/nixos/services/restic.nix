{ ... }:
{

  services.restic = {
    server = {
      enable = false;
      prometheus = true;
    };
  };

}
