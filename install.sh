#!/usr/bin/env bash

set -ue

sudo mv /etc/nixos /etc/nixos.bak
sudo git clone https://github.com/aabs/nixos /etc/nixos
sudo cp /etc/nixos.bak/hardware-configuration.nix /etc/nixos/
