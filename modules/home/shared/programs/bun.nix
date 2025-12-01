{
  programs.bun = {
    enable = true;
    settings = {
      smol = false;
      telemetry = false;
      install = {
        auto = "disable";
        saveTextLockfile = true;
      };
    };
  };
}
