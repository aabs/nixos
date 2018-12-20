{ config, lib, pkgs, ... }:

{
  imports = [
    ../roles/common.nix
    ../roles/development.nix
    ../roles/entertainment.nix
  ];

  networking.hostName = "magnesium";
	networking.networkmanager.enable = true;

  boot = {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "sd_mod" "rtsx_pci_sdmmc" ];
    kernelModules = [ "kvm-intel" "tun" "virtio" ];
  
    initrd.luks.devices = [
      {
        name = "root";
        device = "/dev/sda2";
        preLVM = true;
      }
    ];
  };

  fileSystems."/mnt/d" = { 
	  device = "/dev/disk/by-label/DATA";
	  fsType = "ntfs";
  };

  nix.maxJobs = 2;
}
