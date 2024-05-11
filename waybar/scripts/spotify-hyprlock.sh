#!/bin/bash

class=$(playerctl metadata --player=spotify --format '{{lc(status)}}')
icon=" "

if [[ $class == "playing" ]]; then
	info=$(playerctl metadata --player=spotify --format '{{title}} • {{artist}}')
	info=$(echo -e $info | sed 's/"/\\"/g' | sed 's/&/\\u0026/g')
	if [[ ${#info} -gt 120 ]]; then
		info=$(echo -n $info | cut -c1-120 && echo "\u2026")
	fi
	text=$icon" "$info
elif [[ $class == "paused" ]]; then
	text=""
elif [[ $class == "stopped" ]]; then
	text=""
fi

echo -e "{\"text\":\""$text"\", \"class\":\""$class"\"}"
