self: super: {
  wavebox = super.wavebox.overrideAttrs (oldAttrs: {
    version = "10.126.22-2";
    src = super.fetchurl {
      url = "https://download.wavebox.app/stable/linux/tar/Wavebox_10.126.22-2.tar.gz";
      sha256 = "sha256-geAyd6R0w5pc7ERFPhHTPc4xj0n9VPPEn3ftmD7RXhg=";
    };
  });
}
