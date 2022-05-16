# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "kadath"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  # networking.interfaces.enp3s0f4u2.useDHCP = false;
  networking.interfaces.wlp2s0.useDHCP = false;
  networking.networkmanager.enable = true;
  
  # Custom DNS
  environment.etc = {
    "resolv.conf".text = "nameserver 208.67.222.222\nnameserver 208.67.220.220\nnameserver 8.8.8.8\nnameserver 8.8.4.4\n";
  };
  
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  systemd.services = {
    dhcpcd = {
      enable = false;
      restartIfChanged = false;
    };
    ModemManager = {
      enable = false;
      restartIfChanged = false;
    };
  };
  # systemd stop time
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=5s
  '';

  # ZSH
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Bluetooth
  hardware.bluetooth.enable = true;

  # USB Phone modem?
  # hardware.enp3s0f4u2.enable = false;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false;

  # Pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.barzai = {
    isNormalUser = true;
    initialPassword = "P@ssword";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # Allow proprietary/non-FOSS packages
  nixpkgs.config.allowUnfree = true;

  # Flatpak support
  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget                # Download stuff
    firefox             # Backup browser
    brave               # Brave browser
    ledger-live-desktop # Ledger desktop app
    opensc              # Smart Card support
    neofetch            # Useless frippery
    git                 # git
    # Languages
    go                  # Go
    rustup              # Rust installer
    cargo               # Rust PM
    openjdk             # Java
    gcc                 # C++ compiler
    python3             # Python
    # IDEs etc.
    jetbrains.goland    # Go
    jetbrains.clion     # C++/Rust
    jetbrains.pycharm-professional # Python
    jetbrains.idea-ultimate        # Java
    vscode
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

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
  system.stateVersion = "21.11"; # Did you read the comment?

}

