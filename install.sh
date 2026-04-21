#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
target_dir="${HOME}/.config/hypr/lexi-hyprlock"
hyprlock_conf="${HOME}/.config/hypr/hyprlock.conf"
backup_conf="${hyprlock_conf}.bak.$(date +%Y%m%d_%H%M%S)"

mkdir -p "${target_dir}/assets" "${target_dir}/scripts"
sed "s#__HOME__#${HOME}#g" "${repo_dir}/hyprlock.conf" > "${target_dir}/hyprlock.conf"
cp "${repo_dir}/assets/background.jpg" "${target_dir}/assets/background.jpg"
cp "${repo_dir}/assets/avatar.png" "${target_dir}/assets/avatar.png"
cp "${repo_dir}/scripts/battery-warning.sh" "${target_dir}/scripts/battery-warning.sh"
chmod +x "${target_dir}/scripts/battery-warning.sh"

if [[ -f "${hyprlock_conf}" ]]; then
    cp "${hyprlock_conf}" "${backup_conf}"
    echo "Backed up existing config to ${backup_conf}"
fi

cp "${target_dir}/hyprlock.conf" "${hyprlock_conf}"
echo "Installed Lexi Hyprlock theme to ${target_dir}"
echo "Run: hyprlock"
