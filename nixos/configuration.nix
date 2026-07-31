# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = false;

  # Enable GRUB
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";

  #GRUB scan for OS
  boot.loader.grub.useOSProber = true;

  #GRUB Themes
  boot.loader.grub.theme = /etc/nixos/grub-theme;

  #Clean Menu Entries
  boot.loader.grub.extraEntries = ''
    menuentry "Windows" --class windows --class os {
	search --file --no-floppy --set=root /EFI/Microsoft/Boot/bootmgfw.efi
	chainloader /EFI/Microsoft/Boot/bootmgfw.efi
    }

    submenu "Extra" {
	menuentry "UEFI Firmware Settings" {
		fwsetup
	}
    }
  '';

  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."woeter" = {
    isNormalUser = true;
    description = "woeter";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install Firefox
  programs.firefox.enable = true;
  
  hardware.graphics.enable32Bit = true;  # needed for most games (32-bit game binaries + drivers)

  # Nix Config
  programs.sway.enable = true;
  xdg.portal.wlr.enable = true;

  programs.zsh.enable = true;
  users.users.woeter.shell = pkgs.zsh;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Search Experimental Feature
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 57621 ];
  networking.firewall.allowedUDPPorts = [ 5353 ];

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

  # Packages
  environment.systemPackages = with pkgs; [
	# Free Softwares
	git
	neovim
	wget
	curl
	
	neovim
	obsidian
	vim
	zsh
	gcc
	go
	python3
	nodejs
	postgresql_17
	
	wl-clipboard
	fastfetch

	zip
	unzip

	btop
	bat

	eza
	zoxide
	
	# Not so free Softwares
	spotify
	docker
  ];

  #FILESYSTEMS
  fileSystems."/mnt/c_drive" = {
    device = "/dev/disk/by-uuid/BE20825620821615";
    fsType = "ntfs3";
    options = [ 
      "rw" 
      "uid=1000"
      "gid=100"
      "dmask=0022"
      "fmask=0133"
    ];
  };

  fileSystems."/mnt/d_drive" = {
    device = "/dev/disk/by-uuid/3060E48C60E459DC";
    fsType = "ntfs3";
    options = [ 
      "rw" 
      "uid=1000"
      "gid=100"
      "dmask=0022"
      "fmask=0133"
      "nofail"
    ];
  };
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;

  boot.loader.grub.extraInstallCommands = ''
    ${pkgs.python3}/bin/python3 /etc/nixos/scripts/reorder-grub-menu.py
  '';

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # add specific libs here if a binary complains about missing .so files later
  ];
}

