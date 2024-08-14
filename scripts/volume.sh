#!/bin/sh

if ! command -v wpctl &> /dev/null; then
    echo "error: wpctl is not installed"
    exit 1
fi

current_volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d " " -f 2 | awk '{print int($1 * 100)}')

if [ $# -ne 1 ]; then
    echo "Usage: volume.sh [up|down|toggle-mute]"
    exit 1
fi

case $1 in
    up)
        echo "up"
        if [ $current_volume -lt 100 ]; then
            wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+
        fi
        ;;
    down)
        echo "down $current_volume"
        if [ $current_volume -gt 0 ]; then
            wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-
        fi
        ;;
    toggle-mute)
        echo "toggle-mute"
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
    *)
        echo "Usage: volume.sh [up|down|toggle-mute]"
        exit 1
        ;;
esac