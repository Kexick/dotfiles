#!/bin/bash

volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')
is_muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o "MUTED")

if [ -n "$is_muted" ]; then
  notify-send -a "audio" -h string:x-canonical-private-synchronous:volume "                                          muted" -h int:value:0
else
  notify-send -a 'audio' -h string:x-canonical-private-synchronous:volume -h int:value:"$volume" "Volume: $volume"
fi
