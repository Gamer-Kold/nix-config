# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "pandora"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Karachi";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
    '';

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

# Pipewire stuff
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.talha = {
    isNormalUser = true;
    description = "Talha Qamar";
    extraGroups = [ "networkmanager" "wheel" "input" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

# Enable flatpak
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ 
    pkgs.xdg-desktop-portal-gtk 
    pkgs.xdg-desktop-portal-wlr 
  ];
  xdg.portal.wlr.enable = true;
  xdg.portal.config.common.default = "gtk";
  services.dbus.implementation = "broker";
  services.flatpak.enable = true;

  # make dynamic linking work
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    xorg.libX11
    xorg.libXi
    xorg.libXxf86vm
    xorg.libXtst
    gtk3
    libGL
    glib
    libxkbcommon
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    lua
    python3
    foliate
    kanagawa-gtk-theme
    vscode-langservers-extracted
    jdt-language-server
    pwvucontrol
    lxappearance
    slack
    flameshot
    feh
    nodejs_20
    neovim
    hugo
    nemo
    git
    gnumake
    alacritty
    i3
    sddm
    syncthing
    gcc
    xdg-utils
    xclip
    fluent-reader
    transmission
    vesktop
    rofi
    stow
    qemu_full
    ripgrep
    gdb
    file
    dust
    ffmpeg
    tmux
    unzip
    zip
    SDL2
    jdk
  ];

  fonts.packages = with pkgs;[
    font-awesome
  ];

  hardware.graphics.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.xserver.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;

  # Touchpad jank
  services.libinput.touchpad.tappingButtonMap = "lrm";
  services.libinput.touchpad.middleEmulation = false;
  services.libinput.touchpad.disableWhileTyping = false;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
