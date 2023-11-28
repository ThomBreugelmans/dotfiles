# Dotfiles
my current dotfiles for my setup, consists of my qtile setup, kitty, emacs, eww and neovim (not really used anymore).

## Looks
...

## Requirements
these following packages should be ensured they are installed:
- `qtile`
- `xsecurelock`
- `sddm`
- `sddm-sugar-candy-git`
- `kitty`
- `emacs`
- `neovim`
- `eww (elkowars wacky widgets)`
- `cargo`

## Installation
there is a script called `install.sh` that will link all the required files to their respective locations (that way they stay up to date when this repo is updated).
! note, this script needs to be called with root/sudo as it links the background images to `/usr/share/backgrounds/` and modifies sddm files.
