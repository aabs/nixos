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
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/sda2";
      preLVM = true;
    }
    ];
    initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "sd_mod" "rtsx_pci_sdmmc" ];
    kernelParams = ["acpi=force acpi_osi=Linux"];
    kernelModules = [ "kvm-intel" "tun" "virtio" ];
    blacklistedKernelModules = [ "nouveau" ];
  };

  fileSystems."/mnt/d" = { 
	  device = "/dev/disk/by-label/DATA";
	  fsType = "ntfs";
  };
  services.acpid.enable = true;
  nix.maxJobs = 2;
}
