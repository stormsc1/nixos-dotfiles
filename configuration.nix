# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_DK.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };

  # graphics (was called opengl)
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
	
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.modesetting.enable = true; #required by most wayland compositors
  hardware.nvidia.open = false;

  # fixes some cursor issue (copy pasted form git)
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  # hints electron apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.xkb.layout = "dk";
  services.xserver.xkb.variant = "";

  # Configure console keymap
  console.keyMap = "dk-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # services.printing.drivers = [ pkgs.epson-escpr ];
  # services.printing.browsing = true;
  # services.printing.defaultShared = true;

  # Bluetooth, https://nixos.wiki/wiki/Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true; # provides bluetooth manager and applet

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.storm = {
    isNormalUser = true;
    description = "storm";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # packages currently installed with systemPackages since i am the only user of this system
    ];
  };

  # Fonts
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    nerdfonts
    font-awesome
    google-fonts
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Install firefox.
  programs.firefox.enable = true;
  programs.hyprland.enable = true; 
  programs.xwayland.enable = true; 
  programs.git.enable = true; 

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    kitty
    waybar
    dunst # notification
    libnotify # dep of dunst
    hyprpaper # wallpaper
    wofi # app manager
    nodejs
    # programs
    vscode
    # dev tools
    gh
    go
    kubectl
    cmake
    gcc
    wget
    playerctl # cli for sending commands to MPRIS
    # other
    neofetch
    spotify
    discord-ptb
  ];

  # desktop portal
  xdg.portal.enable = true;
  xdg.portal.xdgOpenUsePortal = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Services
  # services.openssh.enable = true;
  services.dbus.enable = true; # required for a bunch of inter process communication inc. MPRIS

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
