#!/usr/bin/env bash
#
# wlogout with alt layout and style file
#

LAYOUT=${XDG_CONFIG_HOME:-"$HOME/.config"}/wlogout/layout.jsonc
STYLE=${XDG_CONFIG_HOME:-"$HOME/.config"}/wlogout/style.css

if [[ ! `pidof wlogout` ]]; then
	wlogout --layout ${LAYOUT} --css ${STYLE} \
		--buttons-per-row 6 \
		--column-spacing 48 \
		--row-spacing 48 \
		--margin-top 480 \
		--margin-bottom 480 \
		--margin-left 480 \
		--margin-right 480
else
	pkill wlogout
fi
