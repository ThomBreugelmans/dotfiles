#!/bin/bash

if [[ -z $DIR ]]; then echo "[ERROR] This script should not be run by itself! Exiting..."; exit 1; fi;
if [[ -z $INSTALL_COMMAND ]]; then echo "[ERROR] This script should not be run by itself! Exiting..."; exit 1; fi;
if [ -v $PACKAGES ] || [[ "${#PACKAGES[@]}" != "0" ]]; then :; else echo "[ERROR] This script should not be run by itself! Exiting..."; exit 1; fi;

echo "[INFO] Getting components for: Pywal"

declare -A TO_INSTALL
TO_INSTALL=(
    ["pacman"]='python-pywal imagemagick'
    ["apt"]='' # apt does not have it in the package manager, we need to install using pip3
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
    cp -r $DIR/wal ~/.config
fi
