#!/usr/bin/env bash
#
# Command "output * dpms [on|off]" has been deprecated.
# Use "output * power [on|off]" in new version.
#

STATE=${XDG_RUNTIME_DIR:-"/run/user/$(id -u)"}/sway-dpms.state

[[ ! -r ${STATE} ]] && echo 0 > ${STATE}
[[ ! -w ${STATE} ]] && swaymsg "output * dpms on" && exit

read VALUE < $STATE
if [ "$VALUE" -eq "0" ]; then
	swaymsg "output * dpms on"
	echo 1 > ${STATE}
else
	swaymsg "output * dpms off"
	echo 0 > ${STATE}
fi

