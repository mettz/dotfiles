#!/bin/sh

killall waybar

if [[ $USER = "mettz" ]]; then
    waybar -c ~/.config/waybar/config.jsonc & ~/.config/waybar/style.css
else
    waybar &
fi
