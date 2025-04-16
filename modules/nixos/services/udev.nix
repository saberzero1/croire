{ pkgs, ... }:
{

  services.udev = {
    enable = true;
    path = [
      "${pkgs.coreutils-full}/bin"
    ];
    # Disable autosuspend on all USB keyboards and mice
    # extraRules = ''
    #   ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="on"
    #   ACTION=="add", SUBSYSTEM=="usb", TEST=="power/autosuspend", ATTR{power/autosuspend}="0"
    #   ACTION=="add", SUBSYSTEM=="usb", TEST=="power/autosuspend_delay_ms", ATTR{power/autosuspend_delay_ms}="0"
    # '';
  };

}
