#!/bin/sh

WAYBAR_CONFIG_DIR=$(dirname $0)
if [[ !$INSTALL_DIR ]]; then
    INSTALL_DIR=$HOME/.config/waybar
fi

if [[ ! `pacman -Qqs waybar` =~ "waybar" ]]; then
    paru -S waybar
fi

cp $WAYBAR_CONFIG_DIR/style.css $WAYBAR_CONFIG_DIR/config $INSTALL_DIR
