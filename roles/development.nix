{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vscode
    atom
    neovim
    vim
    emacs
    git
    gitAndTools.gitExtras
    gitAndTools.hub
    idea-community
    pycharm-community
    pandoc

  ];

  environment.variables = {
    GTK2_RC_FILES = "${pkgs.gnome_themes_standard}/share/themes/Adwaita/gtk-2.0/gtkrc";
  };

  virtualisation.docker = {
    enable = true;
    extraOptions = "--exec-opt native.cgroupdriver=cgroupfs";
    socketActivation = false;
  };
  #virtualisation.rkt.enable = true;
  #virtualisation.libvirtd.enable = true;

  services.syncthing = {
    #enable = true;
    user = "aabs";
    dataDir = "/home/aabs";
  };

  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.gnome3.enable = true;
    #desktopManager.budgie.enable = true;
    desktopManager.xterm.enable = false;
    synaptics.enable = true;
  };

  services.couchdb = {
    enable = true;
    extraConfig = ''
      [httpd]
      enable_cors = true
      [cors]
      origins = *
      credentials = true
      methods = GET,PUT,POST,HEAD,DELETE
      headers = accept, authorization, content-type, origin
    '';
  };

  services.tarsnap = {
    #enable = true;

    archives.machine.directories = [
      "/etc/nixos"
    ];

    archives.aabs.directories = [
      "/home/aabs/.dotfiles"
      "/home/aabs/.password-store"
      "/home/aabs/.gnupg2"
      "/home/aabs/.ssh"
    ];
  };

  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (subject.isInGroup('wheel')) {
          return polkit.Result.YES;
        }
      });
    '';
  };

}
