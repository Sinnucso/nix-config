# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{inputs, config, lib, pkgs, ... }:

let
  #secret = config.sops.secrets.home_manager_secret.path;
  secret = config.sops.secrets.test.path;
  test_script = pkgs.writeShellScriptBin "asdftest" ''
    echo Hello $(cat ${secret})
    '';

in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
#      <sops-nix/modules/sops> #dont need this bc of https://github.com/nix-community/NixOS-WSL/discussions/374
      ../../modules/system/sops.nix
    ];

#  sops = {
#    defaultSopsFile = ../../secrets.yaml;
#    age.keyFile = "/home/sinnucso/.config/sops/age/keys.txt";
##    secrets.nixos_secret = {
##      sopsFile = ../../secrets.yaml;
##    };
#    secrets.test = {};
#  };

  # plasma.enable=true;

  # Use the systemd-boot EFI boot loader.

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #needed for Suspend then Hibernate (1800 = 30 min)
  systemd.sleep.extraConfig =''
    HibernateDelaySec = 1800
  '';

  #zsh
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];  #needs to be installed first "thefuck"];
      theme = "agnoster";
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "lenovo-nix"; # Define your hostname.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
    options = "eurosign:e,caps:escape";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
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
  #  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sinnucso = {
    isNormalUser = true;
    description = "sinnucso";
    extraGroups = [ "networkmanager" "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      #kdePackages.kate
      kdePackages.filelight
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  #enable kde connect
  programs.kdeconnect.enable = true;


  # neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  
  #disables GUI popup for asking ssh passkeys:
  programs.ssh.enableAskPassword = false;

  # Allow unfree packa ges
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    kdePackages.partitionmanager
    wget
    curl
    home-manager
    git
    tmux
    # teamspeak5_client
    # gamemode   #for steam games optimization, add "gamemoderun %command%" to startoptions
    sops
    ssh-to-age
    age
    obsidian
    spotify
    libreoffice-qt
    test_script
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

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}

