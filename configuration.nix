# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./machines/mg.nix
    ];

  nixpkgs.config.allowUnfree = true; 

  environment.systemPackages = with pkgs; [
    ntfs3g
    wget 
    vim 
    neovim 
    networkmanagerapplet 
    nix-prefetch-scripts 
    firefox
    vimPlugins.spacevim 
    exfat 
    udiskie
    dropbox-cli
    fish
    powerline-go
    ag
    fira
    lastpass-cli
  ];

  system.stateVersion = "18.09"; # Did you read the comment?

}
