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
- `terminator`
- `zsh`
  - `powerlevel10k`
  - `zoxide`
- `emacs`
- `thunar`
- `darkman`
- `veracrypt`
- `nvidia stuff`

## Installation
there is a script called `install.sh` that will link all the required files to their respective locations (that way they stay up to date when this repo is updated).

## Tasklist
- [x] wallpaper setup hyprland
  - [x] configure pywal to generate color palette depending on wallpaper

- [x] wlogout setup hyprland
  - [x] wlogout ricing

- [ ] status bar setup using waybar
  - [x] workspace notifier
  - [x] current window name
  - [x] date and time
  - [x] network information
  - [x] battery status
  - [x] brightness
  - [ ] media information (sound, bluetooth, ?)
    - [ ] media control center
      - [ ] music
      - [ ] sound
	  - [ ] brightness
      - [ ] bluetooth
	  - [ ] network
	    - [ ] network name
	    - [ ] network configuration/connection
      - [ ] notifications(? maybe a separate menu)
- [ ] custom configure minimal statusbar in ewww
  - [ ] minimal icon module for active stuff (network, sound, battery, bluetooth)
  - [ ] whole ass dropdown media control center for more specific config (little like windows 11)
  - [ ] notification center
  - [ ] timer
  - [ ] applets (within media center) for bluetooth and wifi
  - [ ] darkmode
  - [ ] calendar
  - [ ] google calendar integration
  - [ ] agenda/trello integration
  - [ ] keyboard shortcuts to show/hide the different menus (as well as buttons)

- [x] hyprlock setup
  - [x] add keys for reboot, shutdown and sleep etc.

- [ ] wofi styling (depends on application launcher of waybar)

- [ ] nvidia, mainly prime and offloading
      
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
  - [ ] Gtk Theming
- [ ] thunar
- [ ] darkman
  - [ ] dark mode
  - [ ] light mode
      
- [ ] dotfiles autoinstaller
  - [ ] general install script with ability to select systems to install
  - [ ] per configuration/application install script which also installs dependencies
    - [ ] hyprland
      - [x] waybar
      - [ ] wofi
      - [ ] pywal
	    - [ ] imagemagick
      - [ ] hyprlock
      - [ ] wlogout
	  - [ ] polkit-gnome
    - [ ] emacs
    - [ ] kitty
	- [ ] terminator
    - [ ] sddm
      - [ ] sddm-sugar-candy
  - [ ] nvidia
  - [ ] other graphics drivers e.g. for vms
