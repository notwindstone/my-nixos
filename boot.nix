{ pkgs, ... }:
{
  # Defaults
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Xanmod Kernel
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  # Hide Stage 2 and further logs behind the NixOS logo
  boot.plymouth.enable = true;

  # Hide most of the log messages
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "splash"
  ];
}
