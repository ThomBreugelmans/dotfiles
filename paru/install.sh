#!/bin/bash

if [[ -z $DIR ]]; then echo "[ERROR] This script should not be run by itself! Exiting..."; exit 1; fi;
if [[ -z $INSTALL_COMMAND ]]; then echo "[ERROR] This script should not be run by itself! Exiting..."; exit 1; fi;
if [ -v $PACKAGES ] || [[ "${#PACKAGES[@]}" != "0" ]]; then :; else echo "[ERROR] This script should not be run by itself! Exiting..."; exit 1; fi;

echo "[INFO] Getting components for: Paru"

if [[ $CONFIGURE == "true" ]]; then
    # Copy configs over
    (cd /tmp; git clone https://aur.archlinux.org/paru.git; cd paru; makepkg -si;)
    cp -r $DIR/paru ~/.config/
fi
