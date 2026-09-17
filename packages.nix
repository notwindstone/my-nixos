{ pkgs, inputs, ... }:

let
  kaede = pkgs.callPackage ./kaede.nix {};
in
{
  # Unfree software
  nixpkgs.config.allowUnfree = true;

  programs.xwayland.enable = true;
  programs.niri.enable = true;
  programs.firefox.enable = true;
  programs.htop.enable = true;
  programs.vscode.enable = true;
  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };
  programs.thunar = {
    enable = true;
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      # Make an 'update' command run a build with 'nix-output-monitor'
      update = "sudo nixos-rebuild switch |& nom";
      uoh = "echo starting correction💢💢 && sudo nixos-rebuild switch |& nom";
    };

    # Shell customizations
    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };
  programs.git = {
    enable = true;
    config = {
      core.symlinks = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # General
    ayugram-desktop
    discord
    obsidian
    v2raya
    krita

    # Games
    steam-run
    kaede
    inputs.freesmlauncher.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Noctalia shell
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Terminal emulator
    alacritty

    # Documents
    doxx
    onlyoffice-desktopeditors

    # University
    quartus-prime-lite

    # Coding
    bun
    nodejs
    jetbrains.idea-oss
    jetbrains.webstorm
    jetbrains.clion

    # File Manager from KDE (something that does not work in Thunar works here)
    kdePackages.dolphin
    kdePackages.kio
    kdePackages.kio-fuse
    kdePackages.kio-extras
    kdePackages.qtsvg

    # Some packages require this, e.g., Electron-based ones
    xwayland-satellite

    # Clipboard
    wl-clipboard
    cliphist

    # System fetches
    nitch
    pfetch

    # System GUI utilities
    alsa-utils
    gparted

    # CLI utilities
    mpvpaper
    xwayland-run
    unrar
    p7zip
    gh
    git
    nethogs
    nix-output-monitor
    wget
    unzip
  ];
}

