{
  # Performance profiles management
  services.tuned.enable = true;

  # Power management
  services.upower.enable = true;

  # Mounting, trash, and other stuff for File Managers
  services.gvfs.enable = true;

  # File thumbnails in Thunar
  services.tumbler.enable = true;

  # Key remapping daemon
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            mod = "overload(mod, capslock)";
          };
        };
      };
    };
  };

  # X server (not X11)
  services.xserver = {
    enable = true;

    # Niri overwrites keyboard layouts.
    # However, removing this, perhaps, could lead to some problems?
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Gnome Display Manager
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
}
