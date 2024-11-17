#!/usr/bin/env bash
# Updates weather forecast

[ ! -x "$(command -v ansiweather)" ] && exit

ip route | while read VIA _ GATEWAY _; do
	case $VIA in
		default)
			ping -q -w 1 -c 1 "$GATEWAY" >/dev/null || exit
			break ;;
	esac
done

#ansiweather -l Tianjin -u metric -s true -f 1 -a false | cut -d' ' -f2,8-
#ansiweather -l Tianjin -u metric -a false -s true -i true -w true -h true -h true -H true -p true -d true
ansiweather -l Tianjin -u metric -a false -s true -H true -d true
#ansiweather -l Tianjin -u metric -a false -s true -H true
