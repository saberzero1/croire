self: super: {
  wavebox = super.wavebox.overrideAttrs (oldAttrs: {
    version = "10.124.32-2";
    src = super.fetchurl {
      url = "https://download.wavebox.app/stable/linux/tar/Wavebox_10.124.32-2.tar.gz";
      sha256 = "sha256-m6hu7lbHA3I2lIhAfSXF6Vepa+V6h33R1gA6z3eDUrg=";
    };
  });
}
