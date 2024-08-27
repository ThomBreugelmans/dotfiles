#!/bin/bash

if [[ -z $DIR ]]; then echo "[ERROR] This script should not be run by itself! Exiting..."; exit 1; fi;
if [[ -z $INSTALL_COMMAND ]]; then echo "[ERROR] This script should not be run by itself! Exiting..."; exit 1; fi;
if [ -v $PACKAGES ] || [[ "${#PACKAGES[@]}" != "0" ]]; then :; else echo "[ERROR] This script should not be run by itself! Exiting..."; exit 1; fi;

echo "[INFO] Getting components for: SDDM"

declare -A TO_INSTALL
TO_INSTALL=(
    ["pacman"]='sddm qt5-graphicaleffects qt5-quickcontrols2 qt5-svg'
    ["apt"]='sddm qml-module-qtquick-layouts qml-module-qtgraphicaleffects qml-module-qtquick-controls2 libqt5svg5'
)

# Add dependencies to package list
for key in "${!TO_INSTALL[@]}"; do
    if [[ $INSTALL_COMMAND == *"$key"* ]]; then
	IFS=' ' read -ra DEPENDENCY_LIST <<< ${TO_INSTALL[$key]}
	PACKAGES+=("${DEPENDENCY_LIST[@]}")
	break
    fi
done

if [[ $CONFIGURE == "true" ]]; then
    # install configs
    sudo git clone --depth=1 https://gitlab.com/MattJolly/sddm-eucalyptus-drop.git /usr/share/sddm/themes/eucalyptus-drop
    sudo cp $DIR/sddm/backgrounds/* /usr/share/sddm/themes/eucalyptus-drop/Backgrounds/
    sudo sed -i.bak 's/^\(Background="\)[^"]*/\1Backgrounds\/blackarch-simple.jpg/' /usr/share/sddm/themes/eucalyptus-drop/theme.conf
    sudo sed -i 's/^\(AccentColour="\)[^"]*/\1lightblue/' /usr/share/sddm/themes/eucalyptus-drop/theme.conf
    sudo mkdir /etc/sddm.conf.d 2> /dev/null
    sudo cp $DIR/sddm/sddm.conf /etc/sddm.conf.d/sddm.conf
fi
