#!/usr/bin/env bash

[ ! -x $(command -v swaybg) ] && exit

WALLPAPERS=${XDG_DATA_HOME:-"$HOME/.local/share"}/wallpapers

function apply_background {
	while true; do
		pkill -x swaybg
		swaybg --mode stretch --image $(find ${WALLPAPERS} -type f | shuf -n 1) &
		sleep ${1}
	done
}

if [ ${#} -gt 0 ] && [ ${1} -gt 60 ]; then
	apply_background ${1}
else
	apply_background 3600
fi
