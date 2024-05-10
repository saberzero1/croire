self: super: {
  wavebox = super.wavebox.overrideAttrs (oldAttrs: {
    version = "10.124.31-2";
    src = super.fetchurl {
      url = "https://download.wavebox.app/stable/linux/tar/Wavebox_10.124.31-2.tar.gz";
      sha256 = "sha256-yJ+J/81eIR816YUNL2b1cLWRi20jtDWL3LjnxMWIdhQ=";
    };
  });
}
