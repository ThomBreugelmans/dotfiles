#!/bin/sh

#            _     _ _       
# _ ____   _(_) __| (_) __ _ 
#| '_ \ \ / / |/ _` | |/ _` |
#| | | \ V /| | (_| | | (_| |
#|_| |_|\_/ |_|\__,_|_|\__,_|
#                            

PACKAGES=nvidia libva-nvidia-driver cuda nvtop

# SETTING UP KERNEL BUILDING
# add the required kernel modules for modesetting
sed -iE 's/^\(MODULES=([^)]*\)/\1nvidia nvidia_modeset nvidia_uvm nvidia_drm/' /etc/mkinitcpio.conf
# the kms hook needs to be removed
sed -iE 's/^\(HOOKS=(.*\) kms \(.*)\)$/\1 \2/' /etc/mkinitcpio.conf

# INSTALLING REQUIREMENTS
pacman -S $PACKAGES
