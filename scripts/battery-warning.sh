#!/usr/bin/env bash

set -euo pipefail

threshold="${BATTERY_WARNING_THRESHOLD:-10}"
battery="${BATTERY_PATH:-/sys/class/power_supply/BAT0}"

capacity_file="${battery}/capacity"
status_file="${battery}/status"

[[ -r "$capacity_file" && -r "$status_file" ]] || exit 0

capacity="$(cat "$capacity_file")"
status="$(cat "$status_file")"

[[ "$capacity" =~ ^[0-9]+$ ]] || exit 0

if (( capacity <= threshold )) && [[ "$status" != "Charging" && "$status" != "Full" ]]; then
    printf '<span background="#050008" foreground="#e93f77">  LOW BATTERY: %s%%  </span>\n' "$capacity"
fi
