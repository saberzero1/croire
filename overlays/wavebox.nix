self: super: {
  wavebox = super.wavebox.overrideAttrs (oldAttrs: {
    version = "10.124.31-2";
    src = super.fetchurl {
      url = "https://download.wavebox.app/stable/linux/tar/Wavebox_10.124.31-2.tar.gz";
      sha256 = "0sws2ndlimhqq73v2205gvgw1zsh7dhjjp1bz8fivxsxwd72n49d";
    };
  });
}
