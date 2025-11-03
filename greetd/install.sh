#!/bin/bash

if [[ -z $DIR ]]; then echo "[ERROR] This script should not be run by itself! Exiting..."; exit 1; fi;
if [[ -z $INSTALL_COMMAND ]]; then echo "[ERROR] This script should not be run by itself! Exiting..."; exit 1; fi;
if [ -v $PACKAGES ] || [[ "${#PACKAGES[@]}" != "0" ]]; then :; else echo "[ERROR] This script should not be run by itself! Exiting..."; exit 1; fi;

echo "[INFO] Getting components for: Greetd"

declare -A TO_INSTALL
TO_INSTALL=(
    ["pacman"]=''
    ["emerge"]='gui-libs/greetd gui-apps/ReGreet gui-wm/niri'
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
    cp -r $DIR/greetd /etc/greetd
fi
