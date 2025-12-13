{ pkgs, inputs, ... }:
{
  # Unfree software
  nixpkgs.config.allowUnfree = true;

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

    # Games
    steam-run

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
    jetbrains.idea-community-bin
    jetbrains.webstorm
    jetbrains.clion

    # File Manager from KDE (something that does not work in Thunar works here)
    kdePackages.dolphin
    kdePackages.kio
    kdePackages.kio-fuse
    kdePackages.kio-extras
    kdePackages.qtsvg

    # Some packages require this i.e. Electron-based
    xwayland-satellite

    # System fetches
    nitch
    pfetch

    # CLI utilities
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
