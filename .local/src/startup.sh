#!/bin/bas

read MAX_BRIGHTNESS < "/sys/class/backlight/intel_backlight/max_brightness"

init_setup() {
	# launch application programs
	launch_apps &

	# set wallpaper
	#update_wallpaper &

	# blue_light_filter
	redshift -O3000 -v &
}

daemon_setup() {
	# auto sleep after inactivity
	xautolock -time 5 -locker "slock systemctl suspend -i" -corners ---- -cornersize 10 &
	# also do not forget to add systemd sevice `slock@.service` to lock on suspend automatically
	# https://wiki.archlinux.org/title/Slock

	# update status bar of dwm
	update_status_bar &

	# launch notification daemon
	dunst &
}

launch_apps() {
	st -e tmux &
	firefox &
}

update_wallpaper() {
	# setting wallpaper once per login
	feh --bg-fill ~/.local/share/wallpapers/$(ls ~/.local/share/wallpapers/ | shuf -n 1)

	# changing wallpaper at some time interval
	#while feh --bg-fill ~/.local/share/wallpapers/$(ls ~/.local/share/wallpapers/ | shuf -n 1); do sleep 5m; done
}

#handle_battery() {
#	read capacity < "/sys/class/power_supply/BAT1/capacity"
#	read state < "/sys/class/power_supply/BAT1/status"
#
#	charge=""
#	if [[ $state != "Discharging" ]]; then
#		charge="󱐋"
#	fi
#
#	level=$((capacity / 20))
#
#	case $level in
#		0)
#			if [[ $charge == "" ]]; then
#				notifier "/usr/share/icons/Adwaita/symbolic/status/battery-level-0-symbolic.svg" "Battery Low" "Plug in your charger!" 2 1
#			fi
#			echo "󰂎 $capacity%$charge"
#			;;
#		1)
#			echo "󰁻 $capacity%$charge"
#			;;
#		2)
#			echo "󰁽 $capacity%$charge"
#			;;
#		3)
#			echo "󰁿 $capacity%$charge"
#			;;
#		*)
#			echo "󰂁 $capacity%$charge"
#			;;
#	esac
#}

handle_battery() {
	read capacity < "/sys/class/power_supply/BAT1/capacity"
	read state < "/sys/class/power_supply/BAT1/status"

	if [[ $state == "Discharging" ]]; then
		state=""
		if [ $capacity -le 20 ]; then
			notifier "/usr/share/icons/Adwaita/symbolic/status/battery-level-0-symbolic.svg" "Battery Low" "Plug in your charger!" 2 3
		fi
	else
		state="⚡"
	fi
	echo "∎: $capacity%$state"
}

#update_status_bar() {
#	network_interface="wlp9s0"
#	read rx1 < "/sys/class/net/$network_interface/statistics/rx_bytes"
#	read tx1 < "/sys/class/net/$network_interface/statistics/tx_bytes"
#	
#	read MAX_BRIGHTNESS < "/sys/class/backlight/intel_backlight/max_brightness"
#	
#	while :; do
#		sleep 1s
#	
#		# update internet_speed
#		read rx2 < "/sys/class/net/$network_interface/statistics/rx_bytes"
#		read tx2 < "/sys/class/net/$network_interface/statistics/tx_bytes"
#		rx_speed=$(( rx2 - rx1 ))
#		tx_speed=$(( tx2 - tx1 ))
#		rx1=$rx2
#		tx1=$tx2
#		#network_info="󰁅 $rx_speed B/s, 󰁝 $tx_speed B/s"
#		network_info="down: $rx_speed B/s, up: $tx_speed B/s"
#	
#		# update volume
#		volume=$(pactl list sinks | awk -v mute=0 'NR<9 { next; } NR==9 && $2 != "no" { print"󰝟"; exit; } NR==10 { print "󰕾",$5; exit; }')
#		volume=$(pactl list sinks | awk -v mute=0 'NR<9 { next; } NR==9 && $2 != "no" { print"◀×: MUTE"; exit; } NR==10 { print "◀»:",$5; exit; }')
#		# update brightness
#		read current_brightness < "/sys/class/backlight/intel_backlight/brightness"
#		brightness_percentage="󰃟 $(( 100 * current_brightness / MAX_BRIGHTNESS ))%"
#		brightness_percentage="☀: $(( 100 * current_brightness / MAX_BRIGHTNESS ))%"
#	
#		# update date and time info
#		date_time_format=$(date '+%r %a %d %b %y')
#	
#		# dwm status bar
#		xprop -root -set WM_NAME " $network_info | $volume | $brightness_percentage | $(handle_battery) | $date_time_format"
#	done
#}

status_bar() {

	# read MAX_BRIGHTNESS < "/sys/class/backlight/intel_backlight/max_brightness"
	# update volume
	#		volume=$(pactl list sinks | awk -v mute=0 'NR<9 { next; } NR==9 && $2 != "no" { print"󰝟"; exit; } NR==10 { print "󰕾",$5; exit; }')
	volume=$(pactl list sinks | awk -v mute=0 'NR<9 { next; } NR==9 && $2 != "no" { print"◀×: MUTE"; exit; } NR==10 { print "◀»:",$5; exit; }')
	# update brightness
	read current_brightness < "/sys/class/backlight/intel_backlight/brightness"
	#		brightness_percentage="󰃟 $(( 100 * current_brightness / MAX_BRIGHTNESS ))%"
	brightness_percentage="☀: $(( 100 * current_brightness / MAX_BRIGHTNESS ))%"

	# update date and time info
	date_time_format=$(date '+%r %a %d %b %y')

	# dwm status bar
	xprop -root -set WM_NAME " $volume ⵗ $brightness_percentage ⵗ $(handle_battery) ⵗ $date_time_format"
}

update_status_bar() {
	while :; do
		sleep 5s
		status_bar
	done
}

# Export status_bar and handle_battery function to use when updating brightness and volume
export MAX_BRIGHTNESS
export -f handle_battery
export -f status_bar
