#!/usr/bin/env bash

[ ! -x "$(command -v clipman)" ] && exit
[ ! -x "$(command -v jq)" ] && exit

HISTPATH=${XDG_RUNTIME_DIR:-"/run/user/$(id -u)"}/clipman-clipboard.json

case "${1}" in
	"list")
		cat $HISTPATH | jq '.[]'
		;;
	"count")
		cat $HISTPATH | jq '.[]' | wc -l
		;;
	"pick")
		clipman pick --histpath=$HISTPATH --tool wofi
		;;
	"clear")
		clipman clear --histpath=$HISTPATH --tool wofi
		;;
	"clearall")
		clipman clear -all --histpath=$HISTPATH
		;;
	"json")
		COUNT=$(cat $HISTPATH | jq '.[]' | wc -l)
		if [ $COUNT -gt 0 ]; then
			ALT='non-zero'
		else
			ALT='zero'
		fi
		printf '{\"alt\":\"%s\", \"tooltip\":\"%s\"}\n' ${ALT} ${COUNT}' item(s) in the clipboard (Middle-click to clear)'
		;;
	*)
		cat $HISTPATH | jq '.[]'
		;;
esac
