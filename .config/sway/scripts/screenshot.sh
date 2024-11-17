#!/usr/bin/env bash
#
# take screenshot with grim, slurp in wayland
#

PICTURES=$(xdg-user-dir PICTURES)
if [[ ! -d ${PICTURES} ]]; then
	mkdir -p $HOME/Pictures
	PICTURES=$HOME/Pictures
fi
SCREENSHOT="${PICTURES}/screenshot-$(date +'%Y%m%d_%H%M%S').png"

# view screenshot
function image_view() {
	case ${1} in
		--swayimg)
			swayimg ${SCREENSHOT} &>/dev/null &
			;;
		--ristretto)
			ristretto ${SCREENSHOT} &>/dev/null &
			;;
		*)
			;;
	esac
}

# notify screenshot
function notify_view () {
	NOTIFY_SEND="notify-send -a screenshot -u low"
	#paplay /usr/share/sounds/freedesktop/stereo/screen-capture.oga &>/dev/null &
	if [[ -e "${SCREENSHOT}" ]]; then
		#${NOTIFY_SEND} "Screenshot saved and copied to clipboard."
		${NOTIFY_SEND} "Screenshot saved."
		image_view $1
	else
		${NOTIFY_SEND} "Screenshot error."
	fi
}
# countdown
countdown () {
	for SECOND in `seq ${1} -1 1`; do
		notify-send -a countdown -t 1000 -u low "Taking shot in : $SECOND"
		sleep 1
	done
}

function current_output() {
	CURRENT=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
	grim -o ${CURRENT} - | tee "${SCREENSHOT}" | wl-copy -t image
	notify_view $1
}
function delay5_output() {
	CURRENT=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
	countdown '5'
	grim -o ${CURRENT} - | tee "${SCREENSHOT}" | wl-copy -t image
	notify_view $1
}
function current_window() {
	CURRENT=$(swaymsg -t get_tree | jq -j '.. | select(.pid?) | select(.visible?) | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')
	grim -g "${CURRENT}" - | tee "${SCREENSHOT}" | wl-copy -t image
	notify_view $1
}
function current_area() {
	grim -g "$(slurp)" - | tee "${SCREENSHOT}" | wl-copy -t image
	notify_view $1
}

case ${1} in
	--output)
		current_output $2
		;;
	--delay5)
		delay5_output $2
		;;
	--window)
		current_window $2
		;;
	--area)
		current_area $2
		;;
	*)
		echo -e "$0 [options]
Screenshot into image file and clipboard. Available options:
	--output: screenshot current focused output to an image/png file in ~/Pictures
	--delay5: screenshot current focused output to an image/png file in ~/Pictures after delay 5 seconds.
	--window: screenshot current focused window to an image/png file in ~/Pictures
	--area: draw a rectangle area and screenshot the area to an image/png file in ~/Pictures
	--help: show this help"
		;;
esac

