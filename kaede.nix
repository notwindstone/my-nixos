# AI-generated
{
  lib,
  stdenv,
  fetchurl,
  dpkg,
  autoPatchelfHook, # <--- ADDED: Fixes the stub-ld error
  wrapGAppsHook3,
  cairo,
  gdk-pixbuf,
  glib,
  gtk3,
  hicolor-icon-theme,
  libsoup_3,
  pango,
  webkitgtk_4_1,
  
  # --- ADDED: Extra dependencies commonly needed by pre-compiled Tauri binaries ---
  alsa-lib,                 # Audio support
  libayatana-appindicator,  # System tray support
  libxkbcommon,             # Keyboard input
  openssl,                  # Networking/SSL
  wayland,                  # Wayland support
  xorg,                     # X11 support
  libGL,                    # OpenGL/Graphics
  dbus,                     # Desktop Bus
}:

stdenv.mkDerivation rec {
  pname = "kaede";
  version = "0.0.1";

  src = fetchurl {
    url = "https://download1351.mediafire.com/u6cby1czm5qgGkZJ9_h2IQhRzN9d1XGCLIkIadJax0jvoEAYsD5H9uCxy2qhIQA3PXsue6XRKmUWcfooVMdsV3GgX9200lBLLlxi13Gk3FPPyoh0Np4zUWp22t5I3qIMx2GxzLL5p6JIYNHVK3ipEL0J2o9E5zkrUIvM1gY2bdYC/bjiidrkzkrt4xr8/kaede_0.0.1_amd64.deb";
    sha256 = "1fe1c1ff9cf18b706aecfb649e3c98dca27b16a7fdb022881fe2224c3427f3e3";
    # url = "https://github.com/kaede-basement/kaede/releases/download/${version}/kaede_${version}_amd64.deb";
    # sha256 = "0a8bb66e79d1a24922dc480c1ebc2b3fedd3bc804581df014d16446bc2b66918";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook  # <--- This patches the binary paths
    wrapGAppsHook3
  ];

  buildInputs = [
    cairo
    gdk-pixbuf
    glib
    gtk3
    hicolor-icon-theme
    libsoup_3
    pango
    webkitgtk_4_1
    
    # Added for autoPatchelfHook to satisfy dynamic linking:
    alsa-lib
    libayatana-appindicator
    libxkbcommon
    openssl
    wayland
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
    libGL
    dbus
  ];

  unpackPhase = ''
    runHook preUnpack
    dpkg -x $src .
    runHook postUnpack
  '';

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r usr/* $out/
    
    # Ensure the binary has executable permissions
    chmod +x $out/bin/kaede

    runHook postInstall
  '';

  # Tauri apps often suffer from rendering glitches or black screens on Linux
  #preFixup = ''
  #  gappsWrapperArgs+=(
  #    --set WEBKIT_DISABLE_COMPOSITING_MODE "1"
  #  )
  #'';

  meta = with lib; {
    description = "A Minecraft Launcher with plugins";
    homepage = "https://github.com/kaede-basement/kaede";
    license = licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
    mainProgram = "kaede";
  };
}
