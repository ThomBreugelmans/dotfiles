#!/bin/sh -e

##################
# SETTING UP ZSH #
##################
echo "[+] Downloading and installing ZSH requirements..."
# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" > /dev/null
# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k > /dev/null
echo "[+] Linking config file for ZSH (.zshrc)"
ln -s ./.zshrc ~/.zshrc > /dev/null

####################
# SETTING UP EMACS #
####################
echo "[+] Linking config file for emacs (init.el)"
# setting up
mkdir ~/.emacs.d/ > /dev/null
ln -s ./.emacs.d/init.el ~/.emacs.d/init.el > /dev/null

####################
# SETTING UP KITTY #
####################
echo "[+] Linking config file for kitty (kitty.conf)"
ln -s ./.config/kitty ~/.config/kitty

####################
# SETTING UP QTILE #
####################
echo "[+] Linking config file for qtile (config.py)"
ln -s ./.config/qtile ~/.config/qtile
