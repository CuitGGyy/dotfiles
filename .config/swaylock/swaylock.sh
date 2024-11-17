#!/usr/bin/env bash
#
# sway lock screen
#

CONFIG=${XDG_CONFIG_HOME:-"$HOME/.config"}/swaylock/config
DIRPATH=${XDG_DATA_HOME:-"$HOME/.local/share"}/wallpapers

case ${1} in
	--image)
		IMAGE=$(find $DIRPATH -type f | shuf -n 1)
		if [[ -r ${IMAGE} ]]; then
			swaylock --image ${IMAGE} --scaling stretch --config ${CONFIG}
		else
			swaylock --config ${CONFIG}
		fi
		;;
	--help)
		echo -e "$0 [option]
Lock screen immediately. Available options:
	--image: Lock screen with an image background in ${DIRPATH}
	--help: show this help"
		;;
	*)
		swaylock --config ${CONFIG}
		;;
esac

