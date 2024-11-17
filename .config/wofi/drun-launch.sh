#!/usr/bin/env bash
#
# launch wofi with alt config
#

CONFIG=${XDG_CONFIG_HOME:-"$HOME/.config"}/wofi/config
STYLE=${XDG_CONFIG_HOME:-"$HOME/.config"}/wofi/style.css

if [[ ! `pidof wofi` ]]; then
	wofi --show drun --conf ${CONFIG} --style ${STYLE}
else
	pkill wofi
fi
