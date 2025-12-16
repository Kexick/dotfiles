#!/bin/sh
Sel=$(find -L "/home/kexick/wallpapers/" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \))

while IFS= read -r path; do
    echo "label=${path##*/};exec=swww img "$path" -t fade --transition-step 55 --transition-duration 1 --transition-fps 60 --transition-angle 45;wal -t -s -i $path && killall -SIGUSR2 waybar && swaync-client -rs;image=$path;recalculate_score=true;value=$path"
done <<< "$Sel"
