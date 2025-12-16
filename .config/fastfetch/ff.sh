#!/usr/bin/env bash

cfg="$HOME/.config/fastfetch/config.jsonc"
placeholder_raw='UPTIME_PLACEHOLDER'
placeholder_fmt=$(printf '%s' "$placeholder_raw" | sed 's/"/\\"/g')

# 1. Посчитать время
read -r d h m <<<$(awk '{h=($1%86400)/3600; m=($1%3600)/60; printf "%d %d", h, m}' /proc/uptime)
fmt_h=$(printf "%2d" "$h"); [[ "$fmt_h" =~ ^\  ]] && fmt_h="${fmt_h:1}"
fmt_m=$(printf "%2d" "$m"); [[ "$fmt_m" =~ ^\  ]] && fmt_m="${fmt_m:1}"
uptime_str=" ${fmt_h}h ${fmt_m}m"
line=" ┃ 󰅐  ┃       $(printf '%-16s' "$uptime_str" ┃)"
escaped_line=$(printf '%s' "$line" | sed 's/"/\\"/g')

# 2. Заменить плейсхолдер на вычисленное значение
sed -i "s|\"format\": \"$placeholder_fmt\"|\"format\": \"$escaped_line\"|" "$cfg"

# 3. Вывести fastfetch
fastfetch -c "$cfg"

# 4. Вернуть обратно плейсхолдер
sed -i "s|\"format\": \"$escaped_line\"|\"format\": \"$placeholder_fmt\"|" "$cfg"

