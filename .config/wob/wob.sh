#!/usr/bin/env sh
# https://github.com/francma/wob/wiki/wob-wrapper-script
#$1 - accent color. $2 - background color. $3 - overflow color. $4 - new value
# returns 0 (success) if $1 is running and is attached to this sway session; else 1

CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}
RUNTIME_DIR=${XDG_RUNTIME_DIR:-"/run/user/$(id -u)"}

is_running_on_this_screen() {
	pkill -x -0 "wob" || return 1
	for pid in $(pgrep "wob"); do
		WOB_SWAYSOCK="$(tr '\0' '\n' </proc/"$pid"/environ | awk -F'=' '/^SWAYSOCK/ {print $2}')"
		if [ "$WOB_SWAYSOCK" = "$SWAYSOCK" ]; then
			return 0
		fi
	done
	return 1
}

WOB_PIPE="${RUNTIME_DIR}/$(basename "$SWAYSOCK").wobpipe"

[ -p "$WOB_PIPE" ] || mkfifo "$WOB_PIPE"

WOB_INI="$CONFIG_HOME/wob/wob.ini"

refresh() {
	pkill -x wob
	rm $WOB_INI
	{
		echo "anchor = bottom center"
		echo "border_color = $(echo "$1" | sed 's/#//')"
		echo "bar_color = $(echo "$1" | sed 's/#//')"
		echo "background_color = $(echo "$2" | sed 's/#//')"
		#echo "overflow_border_color = $(echo "$1" | sed 's/#//')"
		echo "overflow_bar_color = $(echo "$3" | sed 's/#//')"
		echo "overflow_background_color = $(echo "$2" | sed 's/#//')"
		#echo "margin = 0"
		#echo "border_size = 1"
		#echo "bar_padding = 5"
		#echo "height = 40"
	} >>$WOB_INI
}

if [ ! -f "$WOB_INI" ] || [ "$4" = "--refresh" ]; then
   refresh "$1" "$2" "$3"
fi

## wob does not appear in $(swaymsg -t get_msg), so:
is_running_on_this_screen || {
	tail -f "$WOB_PIPE" | wob -c $WOB_INI &
}

if [ "$4" = "--refresh" ]; then
	exit 0;
elif [ -n "$4" ]; then
	echo "$4" >"$WOB_PIPE"
else
	cat >"$WOB_PIPE"
fi

