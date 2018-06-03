{ config, pkgs, ... }:

let
  secrets = import ../secrets.nix;
in
{
  time.timeZone = "Australia/Melbourne";

  environment.systemPackages = with pkgs; [
    (import ../pkgs/dotfiles.nix)
    usbutils pciutils nfs-utils psmisc file gptfdisk
    git gitAndTools.git-crypt gitAndTools.hub
    python ruby bundler nodejs gcc gnumake
    curl wget bind dhcp unzip
    htop tmux picocom stow duplicity
    neovim
  ];

  environment.variables = {
    EDITOR = "${pkgs.neovim}/bin/nvim";
  };

  programs.fish.enable = true;

  nix.gc.automatic = true;
  nix.useChroot = true;

  hardware.enableAllFirmware = true;

  boot.cleanTmpDir = true;

  boot.kernel.sysctl = {
    "vm.swappiness" = 20;
  };

  security = {
    sudo.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

  services.ntp.enable = true;

  users = {
    mutableUsers = false;

    users.extraUsers.aabs = {
      hashedPassword = secrets.hashedPassword;
      isNormalUser = true;
      home = "/home/aabs";
      shell = "${pkgs.fish}/bin/fish";
      description = "Andrew Matthews";
      uid = 1000;
      extraGroups = [ "wheel" "disk" "cdrom" "docker" "audio" ];
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQgnL+NTsbMCv2N+QMRYf612dD/Z0CE7gBhCYYT08s+ERvRqdCcw8GKSu4L/Sr6qbhMZHarbasCRz+Mcq7I57/R+cdjwSKV85ytmMoHQwmbDDKsCWttsmM831SJw/swZ+v1yxIpQHxY8FTdwnJn9frsXV0c6iJReAJ8ac2ENmm1wDLnp+Iyc+8s07F43P8QtaTAoDz/hFCJnmT54ueqW0YycSeOgKX4ybBYGRWczQziGJHLzxi7OjRg+EzSY+iCKFPKEZoFC9u5hf1FwzpphuyE4SXSa8ZBAWwBpJpi6ftC/6OleV6rSBQbsFHJNl8k3brZTD5LyJo0DnlmqOINGxB aabs@magnesium"
      ];
    };
  };
}
