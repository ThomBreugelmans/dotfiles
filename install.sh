#!/bin/sh -e

if [[ $HOME_DIR -eq "" ]]; then
    $HOME_DIR=$HOME
fi

if [[ "$(which paru)" -eq "" ]]; then
    echo "[!] Paru the AUR helper is not installed, which is required for this script!"
    exit 1;
fi
if [[ "$(which pacman)" -eq "" ]]; then
    echo "[!] This script is meant for Arch (or at least pacman) based distributions!"
    exit 1;
fi

sudo --validate

######################
# LINKING WALLPAPERS #
######################
echo "[+] Linking wallpapers to /usr/share/backgrounds"
sudo cp ./backgrounds /usr/share/

###################
# SETTING UP SDDM #
###################
echo "[+] Installing SDDM and prerequisites..."
paru -S -q --noconfirm sddm sddm-sugar-candy-git
echo "[+] Setting up SDDM config"
sudo rm /usr/share/sddm/themes/sugar-candy/theme.conf /usr/lib/sddm/sddm.conf.d/default.conf > /dev/null
sudo cp ./.config/sddm/theme.conf /usr/share/sddm/themes/sugar-candy/theme.conf
sudo cp ./.config/sddm/default.conf /usr/lib/sddm/sddm.conf.d/default.conf

##################
# SETTING UP ZSH #
##################
echo "[+] Installing ZSH..."
sudo pacman -S -q zsh --noconfirm
echo "[+] Downloading and installing ZSH requirements..."
# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME_DIR/.oh-my-zsh/custom}/themes/powerlevel10k
echo "[+] Linking config file for ZSH (.zshrc)"
cp ./.zshrc $HOME_DIR/.zshrc

####################
# SETTING UP EMACS #
####################
echo "[+] Installing emacs..."
sudo pacman -S -q emacs --noconfirm
echo "[+] Linking config file for emacs (init.el)"
# setting up
mkdir $HOME_DIR/.emacs.d/ > /dev/null
sudo cp ./.emacs.d/init.el $HOME_DIR/.emacs.d/init.el

####################
# SETTING UP KITTY #
####################
echo "[+] Installing kitty..."
sudo pacman -S -q kitty --noconfirm
echo "[+] Linking config file for kitty (kitty.conf)"
sudo cp ./.config/kitty $HOME_DIR/.config/

####################
# SETTING UP QTILE #
####################
echo "[+] Installing qtile and prerequisites..."
sudo pacman -S -q qtile autorandr arandr shotgun hacksaw xclip --noconfirm
echo "[+] Linking config file for qtile (config.py)"
sudo cp ./.config/qtile $HOME_DIR/.config/

