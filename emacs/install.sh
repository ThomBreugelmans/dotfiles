#!/bin/bash

if [[ -z $DIR ]]; then echo "[ERROR] This script should not be run by itself! Exiting..."; exit 1; fi;
if [[ -z $INSTALL_COMMAND ]]; then echo "[ERROR] This script should not be run by itself! Exiting..."; exit 1; fi;
if [ -v $PACKAGES ] || [[ "${#PACKAGES[@]}" != "0" ]]; then :; else echo "[ERROR] This script should not be run by itself! Exiting..."; exit 1; fi;

echo "[INFO] Getting components for: Emacs"

declare -A TO_INSTALL
TO_INSTALL=(
    ["pacman"]='emacs ttf-firacode-nerd'
    ["apt"]='emacs' # has no repository package for the nerdfont so will need to be done manually
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
    # Copy configs over
    mkdir ~/.emacs.d
    cp $DIR/emacs/init.el ~/.emacs.d/init.el
fi
