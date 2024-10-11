# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/30c4a8d2-aef5-4528-a7ec-be0d3d7d3346";
      fsType = "btrfs";
      options = [ "subvol=@nix/@root" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/30c4a8d2-aef5-4528-a7ec-be0d3d7d3346";
      fsType = "btrfs";
      options = [ "subvol=@nix/@home" ];
    };

  fileSystems."/var/log" =
    { device = "/dev/disk/by-uuid/30c4a8d2-aef5-4528-a7ec-be0d3d7d3346";
      fsType = "btrfs";
      options = [ "subvol=@nix/@log" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/30c4a8d2-aef5-4528-a7ec-be0d3d7d3346";
      fsType = "btrfs";
      options = [ "subvol=@nix/@nix" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/E0AF-4033";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp58s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
