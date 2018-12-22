{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim 
    vimPlugins.spacevim 
    exfat 
    udiskie
    dropbox-cli
    fish
    powerline-go
    ag
    fira
    lastpass-cli
    vscode
    neovim
    vim
    dialog
    emacs
    git
    gitAndTools.hub
    jetbrains.idea-community
    jetbrains.pycharm-community
    pandoc
    w3m
    go
    acpi


  ];

  environment.variables = {
    GTK2_RC_FILES = "${pkgs.gnome_themes_standard}/share/themes/Adwaita/gtk-2.0/gtkrc";
  };

# virtualisation.docker = {
# enable = true;
# extraOptions = "--exec-opt native.cgroupdriver=cgroupfs";
# socketActivation = false;
# };
  #virtualisation.rkt.enable = true;
  #virtualisation.libvirtd.enable = true;

  services.syncthing = {
    #enable = true;
    user = "aabs";
    dataDir = "/home/aabs";
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
