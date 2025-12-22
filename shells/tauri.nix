# Run with `nix-shell shell.nix`
let
  pkgs = import <nixpkgs> { };
in
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    rustc
    cargo
    cargo-tauri
    pkg-config
    cmake
    wrapGAppsHook3
    llvmPackages.libllvm
    llvmPackages.lld
    llvmPackages.clang
  ];

  buildInputs = with pkgs;[
    webkitgtk_4_1
    glib
    gsettings-desktop-schemas
    dbus
    openssl_3
    cairo
    gdk-pixbuf
  ];
  shellHook = ''
    export GDK_BACKEND=x11
  '';
  # export WEBKIT_DISABLE_COMPOSITING_MODE=1
  # export WEBKIT_DISABLE_DMABUF_RENDERER=1
  # export GIO_MODULE_DIR=${pkgs.glib-networking}/lib/gio/modules/
  # '';
}

