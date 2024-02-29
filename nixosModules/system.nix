{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    console = {
      enable = true;
    };
    fonts = {
      enableDefaultPackages = true;
      enableGhostscriptFonts = true;
      fontDir = {
        enable = true;
      };
      fontconfig = {
        defaultFonts = {
          monospace = [
            "Fira Code"
          ];
        };
        enable = true;
      };
    };
    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        LANGUAGE = "en_US.UTF-8";
        LC_ADDRESS = "nl_NL.UTF-8";
        LC_COLLATE = "en_US.UTF-8";
        LC_CTYPE = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "nl_NL.UTF-8";
        LC_MESSAGES = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "nl_NL.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "nl_NL.UTF-8";
        LC_TIME = "nl_NL.UTF-8";
      };
      supportedLocales = [
        "en_US.UTF-8/UTF-8"
        "nl_NL.UTF-8/UTF-8"
        "nl_NL/ISO-8859-1"
      ];
    };
    programs = {
      nano = {
        enable = false;
      };
    };
    system = {
      nixos = {
        release = "23.11";
      };
      switch = {
        enable = true;
      };
    };
    time = {
      timeZone = "Europe/Brussels";
    };
  };
}
