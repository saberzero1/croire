self: super: {
  wavebox = super.wavebox.overrideAttrs (oldAttrs: {
    version = "10.127.16-2";
    src = super.fetchurl {
      url = "https://download.wavebox.app/stable/linux/tar/Wavebox_" + "${version}" + ".tar.gz";
      sha256 = "sha256-VKAbgD1Nl9Yd63twkAamAKQv14hzpsbGiHnbFuiii9M=";
    };
  });
}
