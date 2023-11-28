#!/bin/sh -e

HOME_DIR=$HOME

######################
# LINKING WALLPAPERS #
######################
echo "[+] Linking wallpapers to /usr/share/backgrounds"
ln -s ./backgrounds /usr/share/

###################
# SETTING UP SDDM #
###################
echo "[+] Setting up SDDM config"
rm /usr/share/sddm/themes/sugar-candy/theme.conf /usr/lib/sddm/sddm.conf.d/default.conf > /dev/null
ln -s ./.config/sddm/theme.conf /usr/share/sddm/themes/sugar-candy/theme.conf
ln -s ./.config/sddm/default.conf /usr/lib/sddm/sddm.conf.d/default.conf

##################
# SETTING UP ZSH #
##################
echo "[+] Downloading and installing ZSH requirements..."
# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
echo "[+] Linking config file for ZSH (.zshrc)"
sudo ln -s ./.zshrc $HOME_DIR/.zshrc

####################
# SETTING UP EMACS #
####################
echo "[+] Linking config file for emacs (init.el)"
# setting up
mkdir ~/.emacs.d/ > /dev/null
sudo ln -s ./.emacs.d/init.el $HOME_DIR/.emacs.d/init.el

####################
# SETTING UP KITTY #
####################
echo "[+] Linking config file for kitty (kitty.conf)"
sudo ln -s ./.config/kitty $HOME_DIR/.config/

####################
# SETTING UP QTILE #
####################
echo "[+] Linking config file for qtile (config.py)"
sudo ln -s ./.config/qtile $HOME_DIR/.config/
