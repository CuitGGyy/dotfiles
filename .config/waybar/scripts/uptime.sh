#!/usr/bin/env bash

#UPTIME_P=`uptime -p | sed 's/,//g'`
#UPTIME_S=`uptime -s`

echo "{\"text\":\"$(uptime -p | sed 's/,//g')\",\"tooltip\":\"since $(uptime -s)\"}"

