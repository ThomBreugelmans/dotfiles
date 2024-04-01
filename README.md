# Dotfiles
my current dotfiles for my setup, consists of my hyprland setup, kitty, emacs.

## Looks
...

## Requirements
these following packages should be ensured they are installed:
- `hyprland`
- `hyprlock`
- `waybar`
- `pywal`
- `imagemagick`
- `sddm`
- `sddm-sugar-candy-git`
- `dunst`
- `polkit-gnome`
- `kitty`
- `emacs`
- `thunar`
- `darkman`

## Installation
there is a script called `install.sh` that will link all the required files to their respective locations (that way they stay up to date when this repo is updated).

## Tasklist
- [x] wallpaper setup hyprland
  - [x] configure pywal to generate color palette depending on wallpaper

- [x] wlogout setup hyprland
  - [x] wlogout ricing

- [ ] status bar setup using waybar
  - [ ] workspace notifier
  - [ ] app launcher
  - [ ] current window name
  - [ ] date and time
  - [ ] network information
    - [ ] network configuration dropdown menu
  - [ ] cpu/memory information
  - [ ] battery status
  - [ ] media information (sound, bluetooth, ?)
    - [ ] media control center
      - [ ] music
      - [ ] sound
      - [ ] bluetooth
      - [ ] notifications(? maybe a separate menu)

- [x] hyprlock setup

- [ ] wofi styling (depends on application launcher of waybar)
      
- [ ] color palette auto change setup
  - [x] emacs
  - [x] kitty/terminal
  - [x] hyprland
  - [ ] waybar
  - [x] wlogout
  - [x] hyprlock
  - [ ] application launcher (wofi or something else depending on waybar app startup thing)
  
- [ ] GTK
- [ ] Dunst
- [ ] polkit
- [ ] thunar
- [ ] darkman
  - [ ] dark mode
  - [ ] light mode
      
- [ ] dotfiles autoinstaller
  - [ ] general install script with ability to select systems to install
  - [ ] per configuration/application install script which also installs dependencies
    - [ ] hyprland
      - [ ] waybar
      - [ ] wofi
      - [ ] pywal
	    - [ ] imagemagick
      - [ ] hyprlock
      - [ ] wlogout
    - [ ] emacs
    - [ ] kitty
    - [ ] sddm
      - [ ] sddm-sugar-candy
