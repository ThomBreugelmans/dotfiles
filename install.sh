#!/bin/bash -e

# GET SCRIPT SOURCE DIR
SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )


# DETECTING PACKAGE MANAGER
echo "[INFO] Attempting to detect package manager"
INSTALL_COMMAND=""
if command -v pacman &> /dev/null; then
    INSTALL_COMMAND="$(which pacman) -S -q --noconfirm"
fi
if command -v apt &> /dev/null; then
    INSTALL_COMMAND="$(which apt) install"
fi

if [[ $INSTALL_COMMAND == "" ]]; then
    echo "[!] Could not detect package manager, exiting..."
    exit 1
fi
echo "[DEBUG] Selected the following install command: \`$INSTALL_COMMAND\`"

# SELECT CONFIGURATIONS AND THEIR DEPENDENCIES TO INSTALL
echo -e "\nPlease select all packages you want to install:"

CONFIGS=($(basename -a $DIR/*/))
for i in $(seq 0 $((${#CONFIGS[@]} - 1))); do
    echo "$(($i + 1))) ${CONFIGS[$i]}"
done
CHOICES=()
read -p "Choice (you can select multiple, e.g. 1-5,7,9): " CHOICE
IFS=',' read -ra CHOICE_SPLIT <<< "$CHOICE"
for C in "${CHOICE_SPLIT[@]}"; do
    if [[ $C == *"-"* ]]; then
	IFS='-' read -ra RANGE <<< "$C"
	CHOICES+=($(seq ${RANGE[0]} ${RANGE[1]}))
    else
	CHOICES+=("$C")
    fi
done

# SOURCE EACH DEPENDENCIES INSTALL SCRIPTS
CONFIGURE="true"

SUDO_ASKPASS=/bin/false sudo -A whoami &> /dev/null || (echo "Installing packages requires sudo rights, please input password:"; sudo --validate)
#sudo --validate

declare -a PACKAGES
PACKAGES=()
for choice in "${CHOICES[@]}"; do
    source $DIR/${CONFIGS[$((choice - 1))]}/install.sh
done

# INSTALLING PACKAGES
sudo $INSTALL_COMMAND ${PACKAGES[@]}

