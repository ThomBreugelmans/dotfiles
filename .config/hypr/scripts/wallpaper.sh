#!/bin/sh

# TODOS
# - [ ] make this script reload old wallpaper
# - [ ] have this script (partly) manage color schemes of other applications

current_wallpaper="$HOME/.cache/current_wallpaper"
blurred="$HOME/.cache/blurred_wallpaper.png"

if [[ ! $1 == "init" ]]; then
    # select wallpaper by pywal
    wal -q -i /usr/share/wallpapers/ -n -s -t
    # obtain the values (mainly the wallpaper chosen)
    source "$HOME/.cache/wal/colors.sh"
    
    # set cache to current wallpaper
    cp $wallpaper $current_wallpaper

    # create blurred wallpaper
    magick $current_wallpaper -resize 75% $blurred
    magick $blurred -blur "50x30" $blurred
fi

# set the wallpaper
transition_type="wipe"
swww img $current_wallpaper \
    --transition-bezier .43,1.19,1,.4 \
    --transition-fps=60 \
    --transition-type=$transition_type \
    --transition-duration=0.7 \
    --transition-pos "$( hyprctl cursorpos )"

# reload the status bar
# TODO

