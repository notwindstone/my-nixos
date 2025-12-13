{ config, pkgs, lib, ... }:

let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz";
    sha256 = "02ly03p934ywps0rkwj251fszr6x00d9g7ikn9g7qx27xnrv3ka4";
  };
in
{
  imports =
    [
      # What is this...
      (import "${home-manager}/nixos")
    ];

  # Use 'zsh' for root
  users.defaultUserShell = pkgs.zsh;
  users.users.windstone = {
    isNormalUser = true;
    description = "windstone";
    extraGroups = [ "networkmanager" "wheel" ];

    # Use 'zsh' for non-root too
    shell = pkgs.zsh;
  };
  home-manager.users.windstone = { pkgs, ... }: {
    home.packages = [];

    # Overwrite the mouse cursor
    home.pointerCursor =
      let
        getFrom = url: hash: name: {
          enable = true;
          gtk.enable = true;
          name = name;
          size = 48;
          package =
            pkgs.runCommand "handleCursorFiles" {} ''
              mkdir -p $out/share/icons
              ln -s ${pkgs.fetchzip {
                url = url;
                hash = hash;
              }} $out/share/icons/${name}
            '';
        };
      in
        getFrom
          "https://github.com/notwindstone/BlueArchive-Cursors/archive/refs/heads/main.zip"
          "sha256-LLfv0tNbfYOedSzyknFcX70BrNCX2QxcrHGMa09k6Gk="
          "Blue-Archive-Millenium-Cursor";

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "25.11";
  };
}
