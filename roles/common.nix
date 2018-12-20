{ config, pkgs, ... }:

let
  secrets = import ../secrets.nix;
in
{
  time.timeZone = "Australia/Melbourne";

  environment.systemPackages = with pkgs; [
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
  nix.useSandbox = true;

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

    extraUsers.aabs = {
      hashedPassword = secrets.name.hashedPassword;
      isNormalUser = true;
      home = "/home/aabs";
      shell = "${pkgs.fish}/bin/fish";
      description = "Andrew Matthews";
      uid = 1000;
      extraGroups = [ "wheel" "disk" "cdrom" "docker" "audio" ];
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNJNRPE32UQV+ZBU0EdaHDBJUacXUwsJnBpKsFvY4EpVvr/1yWTlGkGZHuaDK6lSPQKiYc+wWYJ9rZuh34l5NjJycpIHyEHYhz5xh6VEraKbHH3eUTbuIVRDrijnt8TGML2VEKYq8mbwFBLsO6tK/pCjX5A1oqsIX+/hdHSVmJ/fCFzigMLY3tzR7mIQcznA2B7SZ0GCO2XdSLmLMdOLaLZvFVozX4LlZCpsLFE3M7MXD+3W97oitgt1YXHeCNBapO44kbWumSE5cR5ErViDmYgbC+iyq73IQgMKciT+R0T1bU0wa9EjD0nf2L+R+ss0Twf6UyW80ZjpStUjB1ghiJ aabs@magnesium"
      ];
    };
  };
}
