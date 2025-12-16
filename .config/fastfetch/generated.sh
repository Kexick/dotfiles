cfg="$HOME/.config/fastfetch/generated.json"

read -r d h m <<<$(awk '{d=$1/86400; h=($1%86400)/3600; m=($1%3600)/60; printf "%d %d %d", d, h, m}' /proc/uptime)
fmt_d=$(printf "%2d" "$d"); [[ "$fmt_d" =~ ^\  ]] && fmt_d="${fmt_d:1}"
fmt_h=$(printf "%2d" "$h"); [[ "$fmt_h" =~ ^\  ]] && fmt_h="${fmt_h:1}"
fmt_m=$(printf "%2d" "$m"); [[ "$fmt_m" =~ ^\  ]] && fmt_m="${fmt_m:1}"
uptime_str="${fmt_d}d ${fmt_h}h ${fmt_m}m"
uptime_line=" ┃ 󰅐  $(printf '%-24s' "$uptime_str") ┃"

cat > "$cfg" <<EOF
{
  "display": {
    "separator": " ┃ ",
    "key": { "paddingLeft": 0 }
  },
  "modules": [
    { "type": "custom", "format": "┎────┰────────────────────────┒" },
    { "type": "os", "key": " ", "format": " ┃ OS  ┃     {name}     ┃" },
    { "type": "custom", "format": " ┠────╂────────────────────────┨" },
    { "type": "kernel", "key": " ┃  ", "format": " {1} {2} ┃" },
    { "type": "cpu", "key": " ┃  ", "format": " {name} ┃" },
    { "type": "gpu", "key": " ┃ 󰾲 ", "format": " {name} ┃" },
    { "type": "memory", "key": " ┃  ", "format": " {total} ┃" },
    { "type": "custom", "format": "$uptime_line" },
    { "type": "custom", "format": " ┖────┸────────────────────────┚" }
  ]
}
EOF

fastfetch -c "$cfg"

