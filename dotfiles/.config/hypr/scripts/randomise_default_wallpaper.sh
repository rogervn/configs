#!/bin/bash

WALLPAPER_DIR=~/.config/hypr/wallpaper
DEFAULT_WALLPAPER_FILE=default.png

cd $WALLPAPER_DIR
random_wallpaper=$(find . -type f | shuf -n 1)
ln -sf $random_wallpaper $DEFAULT_WALLPAPER_FILE


