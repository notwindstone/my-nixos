{
  lib,
  stdenv,
  fetchurl,
  dpkg,
  wrapGAppsHook3,
  cairo,
  gdk-pixbuf,
  glib,
  gtk3,
  hicolor-icon-theme,
  libsoup_3,
  pango,
  webkitgtk_4_1,
}:

stdenv.mkDerivation rec {
  pname = "kaede";
  version = "0.0.1";

  src = fetchurl {
    url = "https://github.com/kaede-basement/kaede/releases/download/${version}/kaede_${version}_amd64.deb";
    sha256 = "0a8bb66e79d1a24922dc480c1ebc2b3fedd3bc804581df014d16446bc2b66918";
  };

  nativeBuildInputs = [
    dpkg
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
  ];

  # Unpack the Debian package directly into the build directory
  unpackPhase = ''
    runHook preUnpack
    dpkg -x $src .
    runHook postUnpack
  '';

  sourceRoot = ".";

  # Move the extracted contents from /usr to the Nix store
  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r usr/* $out/

    runHook postInstall
  '';

  # Tauri apps (which Kaede is) often suffer from rendering glitches or crashes
  # on Linux, especially under Wayland or with NVIDIA drivers.
  # This environment variable fixes those issues.
  preFixup = ''
    gappsWrapperArgs+=(
      --set WEBKIT_DISABLE_COMPOSITING_MODE "1"
    )
  '';

  meta = with lib; {
    description = "A Minecraft Launcher with plugins";
    homepage = "https://github.com/kaede-basement/kaede";
    license = licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
    mainProgram = "kaede";
  };
}
