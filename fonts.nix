{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    # Nerd fonts store patched versions of fonts
    nerd-fonts.droid-sans-mono
    nerd-fonts.iosevka
  ];
}
