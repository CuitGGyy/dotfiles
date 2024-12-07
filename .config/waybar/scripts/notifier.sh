#!/usr/bin/env bash

[ ! -x "$(command -v makoctl)" ] && exit

case $1'' in
'status')
	printf '{\"alt\":\"%s\",\"tooltip\":\"mode: %s\"}' $(makoctl mode | grep -q 'do-not-disturb' && echo do-not-disturb || echo default) $(makoctl mode | tail -1)
	;;
'restore')
	makoctl restore
	;;
'toggle')
	makoctl mode | grep 'do-not-disturb' && makoctl mode -r do-not-disturb || makoctl mode -a do-not-disturb
	;;
esac
