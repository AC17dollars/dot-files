#!/bin/sh

class=$(playerctl metadata --player=spotify --format '{{lc(status)}}')
icon=" "

if [[ $class == "playing" ]]; then
	info=$(playerctl metadata --player=spotify --format '{{title}} • {{artist}}')
	info=$(echo $info | sed 's/"/\\"/g')
	if [[ ${#info} > 40 ]]; then
		info=$(echo -n $info | cut --zero-terminated -c1-40 && echo "…")
	fi
	text=$icon" "$info
elif [[ $class == "paused" ]]; then
	text=""
elif [[ $class == "stopped" ]]; then
	text=""
fi

echo -e "{\"text\":\""$text"\", \"class\":\""$class"\"}"
