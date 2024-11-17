#!/usr/bin/env bash
#
# launch mako with alt config
#

CONFIG=${XDG_CONFIG_HOME:-"$HOME/.config"}/mako/config

if [[ ! `pidof mako` ]]; then
	mako --config ${CONFIG} "$@"
fi
