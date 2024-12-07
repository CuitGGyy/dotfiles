#!/usr/bin/env bash
#
# power menu
#

# config files
CONFIG=${XDG_CONFIG_HOME:-"$HOME/.config"}/wofi/config
STYLE=${XDG_CONFIG_HOME:-"$HOME/.config"}/wofi/style.css

## dmenu command
wofi_command="wofi --show dmenu \
				--conf ${CONFIG} --style ${STYLE} \
				--width=300 --height=320 \
				--cache-file=/dev/null \
				--hide-scroll --no-actions \
				--define=matching=fuzzy"

# uptime
uptime=" $(uptime -p | sed -e 's/,//g' | sed -e 's/up /UP - /g')"

## entries
lock=" Lock"
reload="󰖷 Reload"
#logout=" Logout"
logout="󰋣 Logout"
#suspend=" Suspend"
suspend=" Suspend"
#reboot=" Reboot"
reboot=" Reboot"
shutdown=" Shutdown"

# ask for confirmation
cdialog () {
	yad --title='Confirm?' --borders=15 --center --fixed --undecorated --button=Yes:0 --button=No:1 --text="Are you sure?" --text-align=center
}

# variable passed to rofi
open_wofi_dmenu () {
	options="$lock\n$reload\n$logout\n$suspend\n$reboot\n$shutdown"

	chosen="$(echo -e "$options" | $wofi_command --prompt "$uptime")"
	case $chosen in
		$lock)
			SWAYLOCK=${XDG_CONFIG_HOME:-"$HOME/.config"}/swaylock/swaylock.sh
			[ -x $(command -v $SWAYLOCK) ] && . $SWAYLOCK
			;;
		$reload)
			#cdialog
			if [[ "$?" == 0 ]]; then
				#hyprctl dispatch exit 0
				swaymsg reload
			else
				exit
			fi
			;;
		$logout)
			#cdialog
			if [[ "$?" == 0 ]]; then
				#hyprctl dispatch exit 0
				swaymsg exit
			else
				exit
			fi
			;;
		$suspend)
			#cdialog
			if [[ "$?" == 0 ]]; then
				#mpc -q pause
				#pulsemixer --mute
				#~/.config/hypr/scripts/lockscreen
				SWAYLOCK=${XDG_CONFIG_HOME:-"$HOME/.config"}/swaylock/swaylock.sh
				[ -x $(command -v $SWAYLOCK) ] && . $SWAYLOCK
				sleep 1
				systemctl suspend
			else
				exit
			fi
			;;
		$reboot)
			#cdialog
			if [[ "$?" == 0 ]]; then
				systemctl reboot
			else
				exit
			fi
			;;
		$shutdown)
			#cdialog
			if [[ "$?" == 0 ]]; then
				systemctl poweroff
			else
				exit
			fi
			;;
	esac
}

if [[ ! `pidof wofi` ]]; then
	open_wofi_dmenu
else
	pkill wofi
fi

