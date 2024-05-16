self: super: {
  wavebox = super.wavebox.overrideAttrs (oldAttrs: {
    version = "10.124.32-2";
    src = super.fetchurl {
      url = "https://download.wavebox.app/stable/linux/tar/Wavebox_10.124.32-2.tar.gz";
      sha256 = "sha256-UhG+vUIUHj6BAAVW8jtC1CT05EpPC3kCW6Tvvj8gFmU=";
    };
  });
}
